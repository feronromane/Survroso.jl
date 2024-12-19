using Plots

"""
    visualisation(time, event, group)

Cette fonction permet de visualiser les données (durée de survie et censure)

# Arguments
- `time` : Vecteur des temps de suivi (vecteur de Float64).
- `event` : Vecteur des indicateurs d'événement (vecteur de Bool). `true` pour un événement, `false` pour une censure.

# Retour
Renvoie un graph permettant de visualiser les temps de survie et les censures.
"""


function visualisation(time::Vector{Float64}, event::Vector{Bool})
    ids = 1:length(time) 
    start_times = zeros(length(time))                  
    censoring = .!event

    plot(legend=false, xlabel="Time", ylabel="Subjects")

    #On ajoute les suivis en gris
    for i in 1:length(ids)
        plot!([start_times[i], time[i]], [i, i], lw=4, color=:gray, label="")
        if event[i]
            scatter!([time[i]], [i], color=:blue, marker=:circle, label="", ms=8)
        end
        if censoring[i]
            scatter!([time[i]], [i], color=:red, marker=:x, label="", ms=10)
        end
    end
    title!("Visualization of Survival Data")
end
