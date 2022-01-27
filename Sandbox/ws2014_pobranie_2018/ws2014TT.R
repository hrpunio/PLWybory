#!/usr/bin/Rscript
# Skrypt wykreśla histogramy dla danych z pliku ws2014_komisje.csv
# (więcej: https://github.com/hrpunio/Data/tree/master/ws2014_pobranie_2018)
#
par(ps=6,cex=1,cex.axis=1,cex.lab=1,cex.main=1.2)
k <- read.csv("ws2014TT.csv", sep = ';', header=T, na.string="NA");

str(k)

k$f <- k$kartyWydane  / k$uprawnieni * 100;
##teryt;xteryt;name;areaH;areaKm;popThs;popKm;rankA;rankP;type;
##bb;centerid;terytYY;idk;adres;uprawnieni;kartyOtrzymane;kartyNiewydane;
##kartyWydane;pelnomocnicy;pakiety;kartyWyjete;koperty;kartyNiewazne;kartyWazne;glosy;glosyNiewazne

summary(k$f); fivenum(k$f);

##aggregate (k$f, list(Numer = k$type), fivenum)
aggregate (k$f, list(Numer = k$type), summary)

k$woj <- sprintf ("w%s", substr(k$Tteryt, start=1, stop=3))
aggregate (k$f, list(Numer = k$woj), summary)


summary(k$popKm)


###https://www.statmethods.net/management/variables.html
attach(k)
k$s[popKm <= 60] <- "small"
k$s[popKm > 60 & popKm <= 150] <- "medium"
k$s[popKm > 150 & popKm <= 1400] <- "large"
k$s[popKm > 1400] <- "huge"
detach(k)

aggregate (k$f, list(Numer = k$s), summary)

cases <- nrow(k)

length(which(k$s == 'small')) / cases * 100
length(which(k$s == 'medium')) / cases * 100 
length(which(k$s == 'large')) / cases * 100
length(which(k$s == 'huge')) / cases * 100
