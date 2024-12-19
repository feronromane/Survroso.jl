# Survroso
A mini first try Julia package for survival analysis and statistical modeling.
Survroso.jl is a Julia package designed for survival analysis, providing tools for Kaplan-Meier estimation, risk assessment, and visualizing censored data distributions. It is useful for statisticians and data scientists working with survival analysis data.

## Installation

Survroso.jl can be installed directly from GitHub using Julia's package manager. To install the package, run the following command in the Julia REPL:

```julia
using Pkg
Pkg.add("https://github.com/feronromane/Survroso.jl")
```

## Usage

Here's a quick example of how to use Survroso.jl to perform Kaplan-Meier estimation and plot survival curves:

```julia
using Survroso
using Plots

# Example data
times = [5.0, 6.0, 7.0, 10.0, 12.0, 14.0, 15.0, 18.0, 20.0, 21.0]  # Follow-up times
events = [true, true, false, true, true, false, false, true, true, false]  # Event observed
groups = ["A", "B", "B", "B", "A", "B", "A", "A", "A", "B"]  # Groups

# Perform Kaplan-Meier estimation
results = kaplan_meier(times, events, groups)

# Plot Kaplan-Meier survival curves
plt = plot(title="Kaplan-Meier Survival Curves", xlabel="Time", ylabel="Survival Probability")
unique_groups = unique(groups)
for g in unique_groups
    group_times, group_surv_prob = results[g]
    plot!(plt, group_times, group_surv_prob, label="Group $g", line=:step)
end
display(plt)

# Perform Risks estimation

risk_inst_results = risk_instant(times, events, groups)
risk_cum_results = risk_cumulative(times, events, groups)

# Initialiser le graphique
plt = plot(title="Kaplan-Meier Survival Curves with Risks", 
           xlabel="Time", 
           ylabel="Probability / Risk", 
           legend=:topright, 
           lw=2)

# Ajouter les risques instantanés et cumulés
for g in unique(groups)
    # Risques instantanés
    unique_times, risk_inst = risk_inst_results[g]
    plot!(plt, unique_times, risk_inst, label="Instant Risk Group $g", lw=2, line=:dash)

    # Risques cumulés
    unique_times, risk_cum = risk_cum_results[g]
    plot!(plt, unique_times, risk_cum, label="Cumulative Risk Group $g", lw=2, line=:dot)
end

# Afficher le graphique
display(plt)

# Perform Visualisation of data
visualisation(times, events)

# Perform Visualisation of the distribution
plot_censored_distribution(times,events,groups)

```
## Dependencies

Survroso.jl depends on the following Julia packages:
- `Plots` for plotting
- `KernelDensity` for kernel density estimation (optional)

## Running Tests

To run the tests for Survroso.jl, simply enter the following in the Julia REPL:

```julia
using Pkg
Pkg.test("Survroso")
```


[![Build Status](https://github.com/feronromane/Survroso.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/feronromane/Survroso.jl/actions/workflows/CI.yml?query=branch%3Amaster)
