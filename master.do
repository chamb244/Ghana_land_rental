* run_all.do -- master file for exploratory rental stats, waves 5-7

clear all
set more off
capture log close _all

global repo "/Users/jchamberlin/repos/Ghana_land_rental"

log using "$repo/Ghana_land_rental_exploratory.log", replace text name(master)

do "$repo/Ghana_land_rental_exploratory_w5.do"
do "$repo/Ghana_land_rental_exploratory_w6.do"
do "$repo/Ghana_land_rental_exploratory_w7.do"

log close master
