# Survroso
Ce package permet de calculer des indicateurs d'analyse de survie sur des données et de les visualiser:

'times = [5.0, 6.0, 7.0, 10.0, 12.0, 14.0, 15.0, 18.0, 20.0, 21.0]'
'events = [true, true, false, true, true, false, false, true, true, false]'
'groups = ["A", "B", "B", "B", "A", "B", "A", "A", "A", "B"]'

- estimateur de kaplan meier :  'kaplan_meier(times,events,groups)'
- risques instantanés et cumulés : 'risk_instant(times, events, groups)' 'risk_cumulative(times, events, groups)'
- afficher la distribution des données : 'plot_censored_distribution(times,events,groups)'
- visuaiser les données : 'visualisation(times, events)'

[![Build Status](https://github.com/feronromane/Survroso.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/feronromane/Survroso.jl/actions/workflows/CI.yml?query=branch%3Amaster)
