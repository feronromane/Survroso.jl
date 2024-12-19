"""
    risk_instant(time, event, group)
    risk_cumulative(time, event, group)

Calcule les risques instantanés/risques cumulés. Peuvent être affichés en utilisant : 
plot(risk_instant(T,E,G), lw=2, line=:step)

# Arguments
- `time` : Vecteur des temps de suivi (vecteur de Float64).
- `event` : Vecteur des indicateurs d'événement (vecteur de Bool). `true` pour un événement, `false` pour une censure.
- `group` : Vecteur des groupes d'appartenance (vecteur de String).

# Retour
Renvoie les risques instantanés/cumulés par groupe.
"""

function risk_instant(time::Vector{Float64}, event::Vector{Bool}, group::Vector{String})
    #On vérifie que tous les vecteurs sont valides
    if length(time) != length(event) || length(time) != length(group)
        throw(ArgumentError("Les vecteurs doivent avoir la même longueur"))
    end
    
    unique_groups = unique(group)
    results = Dict{String, Tuple{Vector{Float64}, Vector{Float64}}}()  #Stockage les résultats
    
    for g in unique_groups
        group_indices = findall(x -> x == g, group)
        time_g = time[group_indices]
        event_g = event[group_indices]
        
        #Risques instantanés pour le groupe
        local unique_times = sort(unique(time_g[event_g]))  #Temps uniques où les événements ont eu lieu
        local risk_inst = Float64[]                        
        for t in unique_times
            #Sujets à risque juste avant le temps t
            local at_risk = sum(time_g .>= t)
            #Evénements observés au temps t
            local events_at_t = sum((time_g .== t) .& event_g)
            
            #Risque instantané h(t)
            push!(risk_inst, events_at_t / at_risk)
        end
        
        results[g] = (unique_times, risk_inst)
    end
    
    return results
end





function risk_cumulative(time::Vector{Float64}, event::Vector{Bool}, group::Vector{String})
    #On récupère les risques instantanés par groupe
    risk_inst_grouped = risk_instant(time, event, group)
    results = Dict{String, Tuple{Vector{Float64}, Vector{Float64}}}()  #Stockage des résultats

    for (g, (unique_times, risk_inst)) in risk_inst_grouped
        #Risque cumulé pour le groupe
        local risk_cum = cumsum(risk_inst)  
        results[g] = (unique_times, risk_cum)
    end
    
    return results
end
