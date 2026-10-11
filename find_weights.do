stata
cd "/Users/jchamberlin/Library/CloudStorage/OneDrive-CIMMYT/DATA/Ghana/GLSS6_2012-2013/DATA/STATA/STATA/PARTB"
cd "/Users/jchamberlin/Library/CloudStorage/OneDrive-CIMMYT/DATA/Ghana/GLSS6_2012-2013/DATA/STATA/STATA/PARTA"

local files : dir . files "*.dta"
foreach f of local files {
    quietly describe using "`f'", varlist
    local vars `r(varlist)'
    quietly use "`f'" in 1, clear
    quietly lookfor weight wt wta
    if "`r(varlist)'" != "" {
        display as result "`f'" as text ":  `r(varlist)'"
    }
}
