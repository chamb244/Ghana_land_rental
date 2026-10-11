/* WAVE 7 */

clear all 

set more off

cd "/Users/jchamberlin/Library/CloudStorage/OneDrive-CIMMYT/DATA/Ghana/GLSS7stata/g7PartB/"
ls 
use g7sec8b.dta, clear

* weights
lookfor weight
inspect WTA_S

keep if !missing(s8bq8)

tab s8bq8 [aw=WTA_S]
// 10% plots rented in 
// 15% plots sharecropped in


codebook s8bq8

gen plotacq_bought = inlist(s8bq8,1)
gen plotacq_rentin = inlist(s8bq8,2)
gen plotacq_sharin = inlist(s8bq8,3)
gen plotacq_usefre = inlist(s8bq8,4)
gen plotacq_vilinh = inlist(s8bq8,5,6)
*gen plotacq_villag = inlist(s8bq8,5) 
*gen plotacq_inheri = inlist(s8bq8,6)

collapse (max) plotacq_* (max) farmnum = s8bq3, by(hid clust WTA_S)

tabstat plotacq_* [aw=WTA_S]
// 4% HHs with land rented in 
// 7% HHs with land sharecropped in 
clonevar rentedin = plotacq_rentin
clonevar sharedin = plotacq_sharin
egen shrentin = rowmax(rentedin sharedin)

tabstat rentedin sharedin shrentin [aw=WTA_S]



/* must use another file for rented / shared out, which is only available ag HH-level */
use g7sec8a1.dta, clear/* WAVE 7 */

clear all 

set more off

cd "/Users/jchamberlin/Library/CloudStorage/OneDrive-CIMMYT/DATA/Ghana/GLSS7stata/g7PartB/"
ls 
use g7sec8b.dta, clear

* weights
lookfor weight
inspect WTA_S


tab s8bq8 [aw=WTA_S]
// 10% plots rented in 
// 15% plots sharecropped in


codebook s8bq8

gen plotacq_bought = inlist(s8bq8,1)
gen plotacq_rentin = inlist(s8bq8,2)
gen plotacq_sharin = inlist(s8bq8,3)
gen plotacq_usefre = inlist(s8bq8,4)
gen plotacq_vilinh = inlist(s8bq8,5,6)
*gen plotacq_villag = inlist(s8bq8,5) 
*gen plotacq_inheri = inlist(s8bq8,6)

collapse (max) plotacq_* (max) farmnum = s8bq3, by(hid clust WTA_S)

tabstat plotacq_* [aw=WTA_S]
// 4% HHs with land rented in 
// 7% HHs with land sharecropped in 
clonevar rentedin = plotacq_rentin
clonevar sharedin = plotacq_sharin
egen shrentin = rowmax(rentedin sharedin)

tabstat rentedin sharedin shrentin [aw=WTA_S]



/* must use another file for rented / shared out, which is only available ag HH-level */
use g7sec8a1.dta, clear

* weights
lookfor weight
inspect WTA_S

d s8aq12 s8aq13a s8aq13b s8aq14 s8aq15 s8aq16a s8aq16b
codebook s8aq12 s8aq13b 
gen rentedout = inlist(s8aq12,1) if !missing(s8aq12)
gen rentedout_ha = s8aq13a * 0.404686 if inlist(s8aq13b,1) // Acres to hectares
replace rentedout_ha = s8aq13a * 0.044965 if inlist(s8aq13b,2) // Poles to hectares
replace rentedout_ha = s8aq13a * 0.044965 if inlist(s8aq13b,3) // Ropes to hectares
replace rentedout_ha = s8aq13a * 0.065032 if inlist(s8aq13b,4) // Plot to hectares
replace rentedout_ha = s8aq13a * 1.000000 if inlist(s8aq13b,5) // Hectares

codebook s8aq15 s8aq16b 
gen sharedout = inlist(s8aq15,1) if !missing(s8aq15)
gen sharedout_ha = s8aq16a * 0.404686 if inlist(s8aq16b,1) // Acres to hectares
replace sharedout_ha = s8aq16a * 0.044965 if inlist(s8aq16b,2) // Poles to hectares
replace sharedout_ha = s8aq16a * 0.044965 if inlist(s8aq16b,3) // Ropes to hectares
replace sharedout_ha = s8aq16a * 0.065032 if inlist(s8aq16b,4) // Plot to hectares
replace sharedout_ha = s8aq16a * 1.000000 if inlist(s8aq16b,5) // Hectares

egen shrentout = rowmax(rentedout sharedout)
tabstat rentedout sharedout shrentout [aw=WTA_S]
// rented out 1.3%
// shared out 3.7%
