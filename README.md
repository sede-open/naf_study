# National Attenuation Factor Study

This repository is supplementary material to the manuscript "Building Specific Attenuation Factors for Scenario-Specific Vapor Intrusion Screening" submitted for publication.  It includes the raw data and the code to fully reproduce the ANOVA analysis on the attenuation factors in the manuscript. The results of the analysis can be viewed [here](https://github.com/sede-open/naf_study/blob/main/NAF_Analysis_Report.md).

## Publication Abstract
A comprehensive study was undertaken to derive more scientifically defensible risk-based screening levels (RBSLs) in soil gas for vapor intrusion (VI) than those based on US Environmental Protection Agency’s (USEPA’s) recommended default attenuation factor (AF) of 0.03. The study involved the compilation and analysis of over 26,000 indoor air (CIA) and subsurface (CSSG) vapor concentration data pairs from over 1,541 buildings, 330 sites, and 32 states across the US.  Descriptive statistics and analysis of variance (ANOVA) analyses were used to calculate scenario-specific AFs for the most significant variables based on building-specific AFs for trichloroethylene (TCE) and perchloroethylene (PCE) concentration data.  The 95th percentile AFs concluded from this analysis are up to 10 times less than the USEPA value of 0.03 depending on subsurface vapor sample, building, and foundation types; building construction date; and relative building US geographic location.  The AFs are also relatively consistent across the scenario types and supported by the conceptual model for VI.  The scenario-specific AFs can be used to support more scientifically defensible AFs for VI screening and help underpin regulatory VI guidance development, which in turn helps facilitate the return of contaminated land back to more constructive re-use and direct limited resources toward sites posing the greatest risk.

## Statistical Analysis

### Setup
The analysis is conducted using the open source programming language R - see <https://cran.r-project.org/> for full installation details. It is recommended to use the RStudio Integrated Development Environment to run this analysis using R - See <https://posit.co/downloads/>. 
The following R packages are required to be installed using the following commands: 
```r
install.packages("ggplot2")
install.packages("effects")
install.packages("openxlsx")
```

### Analysis
The underlying ANOVA data set is available to download in Excel format [here](https://github.com/sede-open/naf_study/blob/main/ANOVA_Raw%20Data.xlsx).

The [NAF_Analysis_Report.R](https://github.com/sede-open/naf_study/blob/main/NAF_Analysis_Report.R) is the basic R script to perform the end to end ANOVA analysis on this data set. [NAF_Analysis_Report.Rmd](https://github.com/sede-open/naf_study/blob/main/NAF_Analysis_Report.Rmd) is a R markdown equivalent script which wraps up the analysis into a visual report which can be viewed in either markdown [here](https://github.com/sede-open/naf_study/blob/main/NAF_Analysis_Report.md) or html [here](https://htmlpreview.github.io/?https://github.com/sede-open/naf_study/blob/main/NAF_Analysis_Report.html). 

