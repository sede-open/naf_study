## ----setup, include=FALSE-----------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = FALSE)
library(ggplot2)
library(effects)
library(openxlsx)


## ----inputData, include=TRUE,echo=T-------------------------------------------------------------------------------------------------------------------------------

data<-openxlsx::read.xlsx("ANOVA_Raw Data.xlsx",sheet="ANOVA Data",check.names=FALSE,sep.names = "_")
data$`LOG(AF)`<-log10(data$AF)
data<-data[,names(data)!="AF"] #For simplicity, omit AF column as we are modelling log_10(AF).


#Establishing and ordering the correct factor levels for each categorical variable. 

data$CHEMICAL_TYPE<-factor(as.character(data$CHEMICAL_TYPE),levels=c("PCE","TCE","PCE and TCE"))

data$SAMPLE_TYPE<-factor(trimws(as.character(data$SAMPLE_TYPE)))
data$SAMPLE_TYPE<-factor(as.character(data$SAMPLE_TYPE),levels=c("SUBSLAB","NEAR-SLAB","ALL"))

data$BUILDING_TYPE<-factor(as.character(data$BUILDING_TYPE),levels=c("COMMERCIAL","INDUSTRIAL","INSTITUTIONAL","NON-RESIDENTIAL","RESIDENTIAL","ALL"))
data$FOUNDATION_TYPE<-factor(as.character(data$FOUNDATION_TYPE),levels=c("BASEMENT","CRAWL SPACE/EARTHEN FLOOR","SLAB-ON-GRADE","ALL"))
data$HVAC_OPERATION<-factor(as.character(data$HVAC_OPERATION),levels=c("HVAC-OFF","HVAC-ON","ALL"))

data$RELATIVE_VFC_SOURCE_DEPTH<-factor(as.character(data$RELATIVE_VFC_SOURCE_DEPTH),levels=c("SHALLOW SOIL","DEEP SOIL/GROUNDWATER","ALL"))

data$BUILDING_CONSTRUCTION_DATE<-factor(as.character(data$BUILDING_CONSTRUCTION_DATE),levels=c("PRE-1950","POST-1950","ALL"))
data$CLIMATE_ZONE<-factor(as.character(data$CLIMATE_ZONE),levels=c("ZONES 1-3","ZONES 4-7","ALL"))
data$PREDOMINANT_SOIL_TYPE<-factor(as.character(data$PREDOMINANT_SOIL_TYPE),levels=c("COARSER GRAINED","FINER GRAINED","ALL"))
data$CSSG_ASSUMPTION<-factor(as.character(data$CSSG_ASSUMPTION),levels=c("AVERAGE CSSG","MAXIMUM CSSG"))
data$CSSG_SAMPLE_DEPTH_Delta<-factor(as.character(data$CSSG_SAMPLE_DEPTH_Delta),levels=c("SUBSLAB (z < 3 ft)","3 <= z <= 5 ft","5 < z <=15","z <= 15 ft","z > 15 ft"))
data$TIME_Delta_BETWEEN_CIA_and_CSSG_SAMPLING<-factor(as.character(data$TIME_Delta_BETWEEN_CIA_and_CSSG_SAMPLING),levels=c("t <= 1 day","1 < t <= 14 days","14 < t <= 60 days","t > 60 days","t < 92 days"))
data$LATERAL_SEPARATION_Delta_BETWEEN_CIA_and_CSSG_SAMPLING<-factor(as.character(data$LATERAL_SEPARATION_Delta_BETWEEN_CIA_and_CSSG_SAMPLING),levels=c("x <= 10 ft","10 < x <=50","50 < x <=100","x < 110 ft"))


summary(data)


## ----boxplot, echo=TRUE-------------------------------------------------------------------------------------------------------------------------------------------

YVar<-"LOG(AF)"
VarNames<-setdiff(names(data),YVar)
lmall<-lm(`LOG(AF)`~.,data)


for(i in 1:length(VarNames)){

  print(ggplot(data, aes(!!sym(VarNames[i]), `LOG(AF)`)) + geom_boxplot(fill = 'grey')+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)))
  
}



## ----Stamod1, echo=TRUE-------------------------------------------------------------------------------------------------------------------------------------------
YVar<-"LOG(AF)"
VarNames<-setdiff(names(data),YVar)
lmall<-lm(`LOG(AF)`~.,data)
anova(lmall)


## ----Stamod2, echo=TRUE-------------------------------------------------------------------------------------------------------------------------------------------
InSignifVars<-gsub("`","",as.character(na.omit(rownames(as.data.frame(anova(lmall)))[as.vector(as.data.frame(anova(lmall))["Pr(>F)"]>0.05)])))
SignifVars<-gsub("`","",as.character(na.omit(rownames(as.data.frame(anova(lmall)))[as.vector(as.data.frame(anova(lmall))["Pr(>F)"]<0.05)])))
lmSignif<- lm(`LOG(AF)`~.,data[,!names(data) %in% InSignifVars])
anova(lmSignif)


## ----Stamod4, echo=TRUE-------------------------------------------------------------------------------------------------------------------------------------------



for(i in SignifVars){

  plot(predictorEffects(predictor=i,mod=lmSignif), axes=list(grid=TRUE,
                      x=list(rotate=45,cex=0.75)),lines=list(lty=0),ylim=c(-4.5,-2))
  
}



