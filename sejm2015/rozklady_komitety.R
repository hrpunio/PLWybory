#!/usr/bin/Rscript
# Skrypt wykreślna różnego rodzaju histogramy dla danych z pliku ws2014_komitety_by_komisja_T.csv
# (więcej: https://github.com/hrpunio/Data/tree/master/ws2014_pobranie_2018)
                                        #
estimatedMode <- function(x) { d <- density(x, na.rm=T); d$x[which.max(d$y)] }

showVotes <- function(df, x, co, region, N, minN) {
   ## showVotes = wykreśla histogram dla województwa (region)
   kN <- nrow(df)
   sX <- summary(df[[x]], na.rm=TRUE);
   sV <- sd(df[[x]], na.rm=TRUE)
   ## współczynnik skośności Pearsona
   skewness <- 3 * (sX[["Mean"]] - sX[["Median"]])/sV
   Mo <- estimatedMode(df[[x]])
   skewnessMo <- (sX[["Mean"]] - Mo)/sV
   
   summary_label <- sprintf ("Śr = %.1f\nMe = %.1f\nq1 = %.1f\nq3 = %.1f\nS = %.1f\nW = %.2f", 
     sX[["Mean"]], sX[["Median"]],
     sX[["1st Qu."]], sX[["3rd Qu."]], sV, skewness)
   summary_label_bold <- sprintf ("D = %.2f\nSr - D = %.2f\nWd = %.2f", Mo, sX[["Mean"]] - Mo, skewnessMo)

   if (minN < 1) {
   t <- sprintf("Wybory 2015. Głosy na %s\n%s ogółem %d komisji", co, region, kN ) } 
   else { t <- sprintf("Wybory 2015. Głosy na %s\n%s ogółem %d komisji (N>%d)", co, region, kN, minN ) } 

   h <- hist(df[[x]], breaks=kpN, freq=TRUE, col="orange", main=t, 
     ylab="%", xlab="% poparcia", labels=F, xaxt='n' )
     axis(side=1, at=kpN, cex.axis=2, cex.lab=2)
   ## pozycja tekstu zawierającego statystyki opisowe
   posX <- 0.50 * max(h$counts)
   posY <- 0.66 * max(h$counts)
   text(80, posX, summary_label, cex=1.4, adj=c(0,1))
   text(80, posY, summary_label_bold, cex=1.4, adj=c(0,1), font=4)
}

## Wczytanie danych; obliczenie podst. statystyk:
komisje <- read.csv("komisje-frekwencja-wyniki_terytt_typ.csv", 
   sep = ';', header=T, na.string="NA");

fivenum(komisje$pPSL); fivenum(komisje$pPiS); fivenum(komisje$pPO);

## ## ###
par(ps=6,cex=1,cex.axis=1,cex.lab=1,cex.main=1.2)
kpN <- seq(0, 100, by=2);
kpX <- c(0, 10,20,30,40,50,60,70,80,90, 100);
kN <- nrow(komisje)
region <- "Polska"
minTurnout <- 0

## cała Polska:
showVotes(komisje, "pPSL", "PSL", region, kN, minTurnout);
showVotes(komisje, "pPiS", "PiS", region, kN, minTurnout);
showVotes(komisje, "pPO",  "PO",  region, kN, minTurnout);
showVotes(komisje, "pZLEW", "SLD",  region, kN, minTurnout);

## Cała Polska (bez małych komisji):
## ( późniejszych analizach pomijane są małe komisje)
minTurnout <- 49
komisje <- subset (komisje, lgw > minTurnout); 
kN <- nrow(komisje)

showVotes(komisje, "pPSL", "PSL", region, kN, minTurnout);
showVotes(komisje, "pPiS", "PiS", region, kN, minTurnout);
showVotes(komisje, "pPO",  "PO",  region, kN, minTurnout);

## Typ gminy U/R (U=gmina miejska ; R=inna niż miejska)
komisjeW <- subset (komisje, typ == "U"); 
kN <- nrow(komisjeW)
region <- "Polska/g.miejskie"
showVotes(komisjeW, "pPSL", "PSL", region, kN, minTurnout);
showVotes(komisjeW, "pPiS", "PiS", region, kN, minTurnout);
showVotes(komisjeW, "pPO",  "PO",  region, kN, minTurnout);

komisjeW <- subset (komisje, typ == "R"); 
kN <- nrow(komisjeW)
region <- "Polska/g.niemiejskie"
showVotes(komisjeW, "pPSL", "PSL", region, kN, minTurnout);
showVotes(komisjeW, "pPiS", "PiS", region, kN, minTurnout);
showVotes(komisjeW, "pPO",  "PO",  region, kN, minTurnout);

## woj = dwucyfrowy kod teryt województwa:
komisje$woj <- substr(komisje$terytt, start=2, stop=3)


cN <- c("dolnośląskie", "kujawsko-pomorskie",
 "lubelskie", "lubuskie", "łódzkie", "małopolskie", "mazowieckie",
 "opolskie", "podkarpackie", "podlaskie", "pomorskie", "śląskie",
 "świętokrzyskie", "warmińsko-mazurskie", "wielkopolskie",
 "zachodniopomorskie");
cW <- c("02", "04", "06", "08", "10", "12", "14", "16", "18",
 "20", "22", "24", "26", "28", "30", "32");

## wszystkie województwa po kolei:
for (w in 1:16) {
  wojS <- cW[w]
  ###region <- cN[w];
  region <- sprintf ("%s (%s)", cN[w], wojS);

  komisjeW <- subset (komisje, woj == wojS); ##

  showVotes(komisjeW, "pPSL", "PSL", region, kN, minTurnout);
  showVotes(komisjeW, "pPiS", "PiS", region, kN, minTurnout);
  showVotes(komisjeW, "pPO",  "PO",  region, kN, minTurnout);
}

## ## koniec
