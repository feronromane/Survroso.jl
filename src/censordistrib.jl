using Plots
using StatsPlots  
using KernelDensity

"""
    plot_censored_distribution_density(time, event, group)

Trace les densités continues des données censurées et non censurées pour chaque groupe.

# Arguments
- `time` : Vecteur des temps de suivi (vecteur de Float64).
- `event` : Vecteur des indicateurs d'événement (vecteur de Bool). `true` pour un événement, `false` pour une censure.
- `group` : Vecteur des groupes d'appartenance (vecteur de String).

# Retour
Affiche un graphique montrant les densités continues des données censurées et non censurées par groupe.
"""


function plot_censored_distribution(time::Vector{Float64}, event::Vector{Bool}, group::Vector{String})
    #On vérifie que tous les vecteurs sont valides
    if length(time) != length(event) || length(time) != length(group)
        throw(ArgumentError("Les vecteurs doivent avoir la même longueur"))
    end

    unique_groups = unique(group)

    colors = [:blue, :red, :green, :purple, :orange]  # Couleurs pour les groupes
    color_map = Dict(unique_groups[i] => colors[i] for i in 1:length(unique_groups))

    plt = plot(title="Density Distribution of Censored and Non-Censored Data",
         xlabel="Time",
         ylabel="Density",
         legend=:topright)

    #On affiche la densité pour chaque groupe et type de status (censuré ou non)
    for g in unique_groups
        group_indices = findall(x -> x == g, group)
        time_g = time[group_indices]
        event_g = event[group_indices]

        censored_times = time_g[.!event_g]  #Censuré
        event_times = time_g[event_g]      #Pas censurés

        if !isempty(censored_times)
            density_censored = kde(censored_times)
            plot!(plt,density_censored.x, density_censored.density,
                  label="Censored (Group $g)",
                  lw=2, color=color_map[g], linestyle=:dash)
        end

        if !isempty(event_times)
            density_event = kde(event_times)
            plot!(plt,density_event.x, density_event.density,
                  label="Events (Group $g)",
                  lw=2, color=color_map[g])
        end
    end
    display(plt)
end
