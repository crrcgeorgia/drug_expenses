
set more off

use "http://caucasusbarometer.org/downloads/NDI_2019_July_04.08.19_Public.dta"

//weights
svyset PSU [pweight=WTIND], strata(SUBSTRATUM) fpc(NPSUSS) singleunit(certainty) || ID, fpc(NHHPSU) || _n, fpc(NADHH)



//recoding
foreach var of varlist HHEXPRNT-HHEXPOTH {
recode `var'(1=1) (0 -1 -2=0), gen(`var'_r)
}
foreach var of varlist HHEXPRNT_r-HHEXPOTH_r {
recode `var' (-3 -7 -9=.)
}

foreach var of varlist OWNFRDG-OWNCHTG {
recode `var'(1=1) (0 -1 -2=0), gen(`var'_r)
}
foreach var of varlist OWNFRDG_r-OWNCHTG_r {
recode `var' (-3 -7 -9=.)
}
gen OWN=OWNFRDG_r + OWNCOTV_r + OWNSPHN_r + OWNTBLT_r + OWNCARS_r + OWNAIRC_r + OWNWASH_r + OWNCOMP_r + OWNHWT_r + OWNCHTG_r

recode SUBSTRATUM (10=1 "Capital") (21 22 23 24 25 26=2 "Large urban") (31 32 33 34 51=3 "Small urban") (41 42 43 44 52=4 "Rural"), gen(SET2)





//medicine
svy: logit HHEXPMED b1.SET2 b1.ETHNOCODE b1.RESPSEX b1.AGEGROUP b1.OWN

margins, at(SET2=(1 2 3 4))
marginsplot

margins, at(ETHNOCODE=(1 2))
marginsplot

margins, at(AGEGROUP=(1 2 3))
marginsplot

margins, at(RESPSEX=(1 2))
marginsplot

margins, at (OWN=(1 2 3 4 5 6 7 8 9 10))
marginsplot

svy: logit HHEXPMED b1.SET2 b1.ETHNOCODE b1.RESPSEX b1.AGEGROUP||b1.OWN

margins AGEGROUP, at (OWN=(1 2 3 4 5 6 7 8 9 10))
marginsplot


//medical care
svy: logit HHEXPMECA b1.SET2 b1.ETHNOCODE b1.RESPSEX b1.AGEGROUP b1.OWN

margins, at(SET2=(1 2 3 4))
marginsplot

margins, at(ETHNOCODE=(1 2))
marginsplot

margins, at(AGEGROUP=(1 2 3))
marginsplot

margins, at(RESPSEX=(1 2))
marginsplot

margins, at(OWN=(1 2 3 4 5 6 7 8 9 10))
marginsplot


//loan, installment, mortgage
svy: logit HHEXPLOAN b1.SET2 b1.ETHNOCODE b1.RESPSEX b1.AGEGROUP b1.OWN

margins, at(SET2=(1 2 3 4))
marginsplot

margins, at(ETHNOCODE=(1 2))
marginsplot

margins, at(AGEGROUP=(1 2 3))
marginsplot

margins, at(RESPSEX=(1 2))
marginsplot

margins, at(OWN=(1 2 3 4 5 6 7 8 9 10))
marginsplot


//education costs
svy: logit HHEXPEDCO b1.SET2 b1.ETHNOCODE b1.RESPSEX b1.AGEGROUP b1.OWN

margins, at(SET2=(1 2 3 4))
marginsplot

margins, at(ETHNOCODE=(1 2))
marginsplot

margins, at(AGEGROUP=(1 2 3))
marginsplot

margins, at(RESPSEX=(1 2))
marginsplot

margins, at(OWN=(1 2 3 4 5 6 7 8 9 10))
marginsplot

//food
svy: logit HHEXPFOOD b1.SET2 b1.ETHNOCODE b1.RESPSEX b1.AGEGROUP b1.OWN

margins, at(SET2=(1 2 3 4))
marginsplot

margins, at(ETHNOCODE=(1 2))
marginsplot

margins, at(AGEGROUP=(1 2 3))
marginsplot

margins, at(RESPSEX=(1 2))
marginsplot

margins, at(OWN=(1 2 3 4 5 6 7 8 9 10))
marginsplot

s
//utilities
svy: logit HHEXPUTL b1.SET2 b1.ETHNOCODE b1.RESPSEX b1.AGEGROUP b1.OWN

margins, at(SET2=(1 2 3 4))
marginsplot

margins, at(ETHNOCODE=(1 2))
marginsplot

margins, at(AGEGROUP=(1 2 3))
marginsplot

margins, at(RESPSEX=(1 2))
marginsplot

margins, at(OWN=(1 2 3 4 5 6 7 8 9 10))
marginsplot


stop

