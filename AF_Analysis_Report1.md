Attentuation Factors Analysis Report
================
2025-05-07

## Exploratory Data Analysis

``` r
#data<-read.csv("National Empirical VI Database_2025-8-10_AF correlations.v2.csv",check.names = FALSE,as.is=FALSE)
#names(data)<-gsub(" ","_",names(data))
#tr<-read.xlsx("temp.xlsx","CORRELATIONS (2)",check.names=FALSE,sep.names = "_")
data<-openxlsx::read.xlsx("temp.xlsx","CORRELATIONS (2)",check.names=FALSE,sep.names = "_")
data<-data[,names(data)!="AF"] #For simplicity, omit AF column as we are modelling log_10(AF).

data$SAMPLE_TYPE<-factor(trimws(as.character(data$SAMPLE_TYPE)))
data$Chemical_Type<-factor(as.character(data$Chemical_Type),levels=c("PCE","TCE","PCE and TCE"))
data$SAMPLE_TYPE<-factor(as.character(data$SAMPLE_TYPE),levels=c("SUBSLAB","SOIL GAS","ALL"))
data$BUILDING_TYPE<-factor(as.character(data$BUILDING_TYPE),levels=c("COMMERCIAL","INDUSTRIAL","INSTITUTIONAL","NON-RESIDENTIAL","NON-RESIDENTIAL (SAME BLDG)","RESIDENTIAL","RESIDENTIAL (SAME BLDG)","ALL"))

data$FOUNDATION_TYPE<-factor(as.character(data$FOUNDATION_TYPE),levels=c("BASEMENT","CRAWL SPACE/EARTHEN FLOOR","SLAB-ON-GRADE","ALL"))
data$HVAC_OPERATION<-factor(as.character(data$HVAC_OPERATION),levels=c("HVAC-OFF","HVAC-ON","ALL"))
data$REL_SOURCE_DEPTH<-factor(as.character(data$REL_SOURCE_DEPTH),levels=c("SHALLOW","DEEP","ALL"))
data$BUILDING_AGE<-factor(as.character(data$BUILDING_AGE),levels=c("PRE-1950","POST-1950","ALL"))
data$GEOGRAPHIC_REGION<-factor(as.character(data$GEOGRAPHIC_REGION),levels=c("REGIONS 1-3","REGIONS 4-7","ALL"))
data$SOIL_TYPE<-factor(as.character(data$SOIL_TYPE),levels=c("COARSER GRAINED","FINER GRAINED","ALL"))
data$VERTICAL_SEPARATION_DISTANCE<-factor(as.character(data$VERTICAL_SEPARATION_DISTANCE),levels=c("z <= 1 ft","1 < z <= 5 ft","5 < z <=15","z < 15 ft","z > 15 ft"))
data$TIME_BETWEEN_SAMPLING<-factor(as.character(data$TIME_BETWEEN_SAMPLING),levels=c("t <= 1 day","1 < t <= 14 days","14 < t <= 60 days","t > 60 days","t < 92 days"))
data$LATERAL_SEPARATION_DISTANCE<-factor(as.character(data$LATERAL_SEPARATION_DISTANCE),levels=c("x <= 10 ft","10 < x <=50","50 < x <=100","x < 110 ft"))
#data$x<-rnorm(nrow(data))
summary(data)
```

    ##      Chemical_Type    SAMPLE_TYPE                       BUILDING_TYPE 
    ##  PCE        : 458   SUBSLAB :1390   ALL                        :1719  
    ##  TCE        : 592   SOIL GAS: 800   NON-RESIDENTIAL            :1586  
    ##  PCE and TCE:3504   ALL     :2364   RESIDENTIAL                : 578  
    ##                                     COMMERCIAL                 : 258  
    ##                                     NON-RESIDENTIAL (SAME BLDG): 196  
    ##                                     INSTITUTIONAL              :  88  
    ##                                     (Other)                    : 129  
    ##                   FOUNDATION_TYPE  HVAC_OPERATION REL_SOURCE_DEPTH
    ##  BASEMENT                 :  34   HVAC-OFF: 132   SHALLOW:  95    
    ##  CRAWL SPACE/EARTHEN FLOOR:  15   HVAC-ON : 156   DEEP   : 117    
    ##  SLAB-ON-GRADE            : 229   ALL     :4266   ALL    :4342    
    ##  ALL                      :4276                                   
    ##                                                                   
    ##                                                                   
    ##                                                                   
    ##     BUILDING_AGE    GEOGRAPHIC_REGION           SOIL_TYPE   
    ##  PRE-1950 : 108   REGIONS 1-3: 392    COARSER GRAINED:  15  
    ##  POST-1950: 114   REGIONS 4-7: 201    FINER GRAINED  :  16  
    ##  ALL      :4332   ALL        :3961    ALL            :4523  
    ##                                                             
    ##                                                             
    ##                                                             
    ##                                                             
    ##  VERTICAL_SEPARATION_DISTANCE       TIME_BETWEEN_SAMPLING
    ##  z <= 1 ft    : 186           t <= 1 day       : 180     
    ##  1 < z <= 5 ft:  98           1 < t <= 14 days :  65     
    ##  5 < z <=15   :  72           14 < t <= 60 days:  80     
    ##  z < 15 ft    :4166           t > 60 days      :  65     
    ##  z > 15 ft    :  32           t < 92 days      :4164     
    ##                                                          
    ##                                                          
    ##  LATERAL_SEPARATION_DISTANCE    LOG(AF)       
    ##  x <= 10 ft  : 147           Min.   :-6.8403  
    ##  10 < x <=50 : 183           1st Qu.:-4.1505  
    ##  50 < x <=100:  90           Median :-3.3823  
    ##  x < 110 ft  :4134           Mean   :-3.4670  
    ##                              3rd Qu.:-2.7570  
    ##                              Max.   :-0.9117  
    ## 

### Independent 1 by 1 Boxplots

![](AF_Analysis_Report1_files/figure-gfm/boxplot-1.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-2.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-3.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-4.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-5.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-6.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-7.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-8.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-9.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-10.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-11.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/boxplot-12.png)<!-- -->

## Statistical Modelling

### Linear Modelling and ANOVA (Analysis of Variance)

    ## Analysis of Variance Table
    ## 
    ## Response: LOG(AF)
    ##                                Df Sum Sq Mean Sq F value    Pr(>F)    
    ## Chemical_Type                   2    0.4   0.176  0.2186 0.8036731    
    ## SAMPLE_TYPE                     2   64.4  32.188 39.9579 < 2.2e-16 ***
    ## BUILDING_TYPE                   7  123.8  17.683 21.9512 < 2.2e-16 ***
    ## FOUNDATION_TYPE                 3   22.2   7.387  9.1706 4.780e-06 ***
    ## HVAC_OPERATION                  2    2.1   1.047  1.3002 0.2725769    
    ## REL_SOURCE_DEPTH                2    5.6   2.799  3.4747 0.0310536 *  
    ## BUILDING_AGE                    2   24.2  12.118 15.0431 3.080e-07 ***
    ## GEOGRAPHIC_REGION               2   54.0  27.024 33.5465 3.452e-15 ***
    ## SOIL_TYPE                       2    0.5   0.233  0.2889 0.7491134    
    ## VERTICAL_SEPARATION_DISTANCE    4   11.7   2.931  3.6387 0.0057706 ** 
    ## TIME_BETWEEN_SAMPLING           4   15.7   3.920  4.8659 0.0006480 ***
    ## LATERAL_SEPARATION_DISTANCE     2   14.8   7.394  9.1788 0.0001051 ***
    ## Residuals                    4519 3640.3   0.806                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Removing insignificant variables:

    ## Analysis of Variance Table
    ## 
    ## Response: LOG(AF)
    ##                                Df Sum Sq Mean Sq F value    Pr(>F)    
    ## SAMPLE_TYPE                     2   64.5  32.270 40.0821 < 2.2e-16 ***
    ## BUILDING_TYPE                   7  123.1  17.588 21.8454 < 2.2e-16 ***
    ## FOUNDATION_TYPE                 3   22.2   7.388  9.1762 4.742e-06 ***
    ## REL_SOURCE_DEPTH                2    5.7   2.867  3.5610 0.0284898 *  
    ## BUILDING_AGE                    2   23.3  11.625 14.4399 5.608e-07 ***
    ## GEOGRAPHIC_REGION               2   56.0  28.016 34.7988 1.005e-15 ***
    ## VERTICAL_SEPARATION_DISTANCE    4   11.6   2.903  3.6052 0.0061192 ** 
    ## TIME_BETWEEN_SAMPLING           4   15.1   3.768  4.6803 0.0009055 ***
    ## LATERAL_SEPARATION_DISTANCE     3   15.8   5.282  6.5613 0.0002012 ***
    ## Residuals                    4524 3642.2   0.805                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Investigate individual effects:

![](AF_Analysis_Report1_files/figure-gfm/Stamod4-1.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/Stamod4-2.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/Stamod4-3.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/Stamod4-4.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/Stamod4-5.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/Stamod4-6.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/Stamod4-7.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/Stamod4-8.png)<!-- -->![](AF_Analysis_Report1_files/figure-gfm/Stamod4-9.png)<!-- -->
