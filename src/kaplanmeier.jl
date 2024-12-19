"""
    kaplan_meier(time, event, group)

Cette fonction permet de calculer et visualiser l'estimateur de Kaplan Meier. 
Ils peuvent être visualiser en utilisant : plot(kaplan_meier(time, event, group),line=:step)

# Arguments
- `time` : Vecteur des temps de suivi (vecteur de Float64).
- `event` : Vecteur des indicateurs d'événement (vecteur de Bool). `true` pour un événement, `false` pour une censure.
- `group` : Vecteur des groupes d'appartenance (vecteur de String).

# Retour
Renvoie les estimateurs de Kaplan Meier par groupe.
"""

function kaplan_meier(time::Vector{Float64}, event::Vector{Bool}, group::Vector{String})
    #On vérifie que tous les vecteurs sont valides
    if length(time) != length(event) || length(time) != length(group)
        throw(ArgumentError("Les vecteurs doivent avoir la même longueur"))
    end
    
    unique_groups = unique(group)
    results = Dict{String, Tuple{Vector{Float64}, Vector{Float64}}}()  #résultats par groupe

    #On calcule l'estimateur de Kaplan-Meier pour chaque groupe
    for g in unique_groups
        group_indices = findall(x -> x == g, group)
        time_g = time[group_indices]
        event_g = event[group_indices]

        #Tri par temps croissant
        sorted_indices = sortperm(time_g)
        time_g = time_g[sorted_indices]
        event_g = event_g[sorted_indices]

        n = length(time_g)
        survival_prob = Float64[]  # Probabilités de survie
        survival = 1.0             # Probabilité initiale
        unique_times = Float64[]   # Points de temps uniques
        n_at_risk = n              # Nombre à risque au début

        #Boucle sur les temps pour ce groupe
        for i in 1:n
            if i == 1 || time_g[i] != time_g[i - 1]
                push!(unique_times, time_g[i])
                d_i = sum(event_g[j] && time_g[j] == time_g[i] for j in 1:n)  # Nb événements à t_i
                n_i = n_at_risk                                              # Nb à risque juste avant t_i
                survival *= (1 - d_i / n_i)                                 # Proba survie
                push!(survival_prob, survival)                              # Stocker S(t)
            end
            n_at_risk -= 1  
        end

        #Stockage des résultats
        results[g] = (unique_times, survival_prob)
    end

    return results
end

