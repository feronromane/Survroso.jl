using Test
using Survroso

#Données simulées
times = [5.0, 6.0, 7.0, 10.0, 12.0, 14.0, 15.0, 18.0, 20.0, 21.0]
events = [true, true, false, true, true, false, false, true, true, false]
groups = ["A", "B", "B", "B", "A", "B", "A", "A", "A", "B"]

# Appel des fonctions
kaplan_meier(times, events, groups) 
risk_inst_results = risk_instant(times, events, groups) 
risk_cum_results = risk_cumulative(times, events, groups) 
visualisation(times, events)
censordistrib(times,events,groups)
