#!/usr/bin/Rscript
# Skrypt wykreśla histogramy dla danych z pliku ws2014_komisje.csv
# (więcej: https://github.com/hrpunio/Data/tree/master/ws2014_pobranie_2018)
#
require (ggplot2)

par(ps=6,cex=1,cex.axis=1,cex.lab=1,cex.main=1.2)
komisje <- read.csv("ws2014_komisje.csv", sep = ';',
       header=T, na.string="NA");

komisje$ogn <- komisje$glosyNiewazne  / (komisje$glosy + komisje$glosyNiewazne) * 100;
komisje$freq <- komisje$kartyWydane  / komisje$uprawnieni * 100;

##
summary(komisje$freq); fivenum(komisje$freq);
sX <- summary(komisje$freq);
sF <- fivenum(komisje$freq);
sV <- sd(komisje$freq, na.rm=TRUE)
skewness <- 3 * (sX[["Mean"]] - sX[["Median"]])/sV

summary_label <- sprintf ("Śr = %.1f\nMe = %.1f\nq1 = %.1f\nq3 = %.1f\nW = %.2f", 
  sX[["Mean"]], sX[["Median"]], sX[["1st Qu."]], sX[["3rd Qu."]], skewness)

## ##
kpN <- seq(0, 100, by=1);
kpX <- c(0, 10,20,30,40,50,60,70,80,90, 100);
nn <- nrow(komisje)

h <- hist(komisje$freq, breaks=kpN, freq=TRUE,
   col="orange", main=sprintf ("Wybory do sejmików 2014. Frekwencja (%%)\nPolska ogółem (%i komisji)", nn), 
   ylab="%", xlab="% nieważne", labels=F, xaxt='n' )
   axis(side=1, at=kpN, cex.axis=2, cex.lab=2)
   posX <- .5 * max(h$counts)
text(80, posX, summary_label, cex=1.4, adj=c(0,1))


##

summary(komisje$glosyNiewazne); fivenum(komisje$glosyNiewazne);
sX <- summary(komisje$ogn);
sF <- fivenum(komisje$ogn);
sV <- sd(komisje$ogn, na.rm=TRUE)
skewness <- 3 * (sX[["Mean"]] - sX[["Median"]])/sV

summary_label <- sprintf ("Śr = %.1f\nMe = %.1f\nq1 = %.1f\nq3 = %.1f\nW = %.2f", 
  sX[["Mean"]], sX[["Median"]], sX[["1st Qu."]], sX[["3rd Qu."]], skewness)

## ##
kpN <- seq(0, 100, by=1);
kpX <- c(0, 10,20,30,40,50,60,70,80,90, 100);
nn <- nrow(komisje)

h <- hist(komisje$ogn, breaks=kpN, freq=TRUE,
   col="orange", main=sprintf ("Wybory do sejmików 2018. Głosy nieważne (%%)\nPolska ogółem (%i komisji)", nn), 
   ylab="%", xlab="% nieważne", labels=F, xaxt='n' )
   axis(side=1, at=kpN, cex.axis=2, cex.lab=2)
   posX <- .5 * max(h$counts)
text(80, posX, summary_label, cex=1.4, adj=c(0,1))

#####

## Wykresy rozrzutu  ## ###
lm <- lm(data=komisje, freq ~ ogn ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("ogn = %.2f freq + %.1f", lmc[2], lmc[1] );

ggplot(komisje, aes(x = freq, y=ogn )) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="freq") +
  ylab(label="ogn") +
  geom_smooth(method = "lm", colour = 'black')



## ##
komisje$woj <- substr(komisje$teryt, start=1, stop=2)

komisjeW <- subset (komisje, woj == "22"); ## pomorskie
nn <- nrow(komisjeW)
sX <- summary(komisjeW$ogn); sF <- fivenum(komisjeW$ogn);
sV <- sd(komisjeW$ogn, na.rm=TRUE)
skewness <- 3 * (sX[["Mean"]] - sX[["Median"]])/sV

summary_label <- sprintf ("Śr = %.1f\nMe = %.1f\nq1 = %.1f\nq3 = %.1f\nW = %.2f", 
  sX[["Mean"]], sX[["Median"]], sX[["1st Qu."]], sX[["3rd Qu."]], skewness)

h <- hist(komisjeW$ogn, breaks=kpN, freq=TRUE,
   col="orange", main=sprintf("Rozkład odsetka głosów nieważnych\nPomorskie %i komisji", nn), 
   ylab="%", xlab="% nieważne", labels=T, xaxt='n' )
   axis(side=1, at=kpX, cex.axis=2, cex.lab=2)
   posX <- .5 * max(h$counts)
text(80, posX, summary_label, cex=1.4, adj=c(0,1))

komisjeW <- subset (komisje, woj == "14"); ## mazowieckie
nn <- nrow(komisjeW)
sX <- summary(komisjeW$ogn); sF <- fivenum(komisjeW$ogn);
sV <- sd(komisjeW$ogn, na.rm=TRUE)
skewness <- 3 * (sX[["Mean"]] - sX[["Median"]])/sV

summary_label <- sprintf ("Śr = %.1f\nMe = %.1f\nq1 = %.1f\nq3 = %.1f\nW = %.2f", 
  sX[["Mean"]], sX[["Median"]], sX[["1st Qu."]], sX[["3rd Qu."]], skewness)

h <- hist(komisjeW$ogn, breaks=kpN, freq=TRUE,
   col="orange", main=sprintf("Rozkład odsetka głosów nieważnych\nMazowieckie %i komisji", nn), 
   ylab="%", xlab="% nieważne", labels=T, xaxt='n' )
   axis(side=1, at=kpX, cex.axis=2, cex.lab=2)
   posX <- .5 * max(h$counts)
text(80, posX, summary_label, cex=1.4, adj=c(0,1))


