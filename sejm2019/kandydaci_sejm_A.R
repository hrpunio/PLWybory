require(ggplot2)


k0 <- read.csv("QQ.csv", sep = ';',  header=T, na.string="NA");

kx <-  subset(k0, (plec == "Kobieta" ))
kk <-  subset(kx, (komitet == "SLD" ))


gmina.sld.k <- ggplot(kk, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydatki SLD wg typu gminy") +
 ylab(label="N") +
 geom_bar(aes(x = typ), fill="steelblue")

gmina.sld.k

