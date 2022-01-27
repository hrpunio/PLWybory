require(ggplot2)
require(ggpubr)


k0 <- read.csv("kandydaci_sejm_cc00.csv", sep = ';',  header=T, na.string="NA");
k0 <- subset(k0, (komitet == "PiS" | komitet == "KOBW" | komitet == "PSL" | komitet == "SLD"))

k0$typ <- gsub('mm', 'gm', k0$typ)


total <- 918
total5 <- 41 * 5

gminaN <- ggplot(k0) +
 ggtitle("Sejm 2019: kandydaci wg m. zamieszkania") +
 ylab(label="N") +
 geom_bar(aes(x = typ), fill="#e2891d")

gminaP <- ggplot(k0, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydaci wg m. zamieszkania") +
 ylab(label="%") +
 scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9), labels=c("10", "20", "30", "40", "50", "60", "70", "80", "90")) +
 ##geom_bar(aes(y = (..count..)/total5), fill="steelblue")
 geom_bar(aes(y = (..count..)/sum(..count..)), fill="steelblue")

#gminaN
#gminaP 

kx <-  subset(k0, (plec == "Kobieta" ))

gminaP.kobiety <- ggplot(kx, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydaci wg m. zamieszkania (kobiety)") +
 ylab(label="%") +
 scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9), labels=c("10", "20", "30", "40", "50", "60", "70", "80", "90")) +
 geom_bar(aes(y = (..count..)/sum(..count..)), fill="steelblue")

#gminaP.kobiety 

## kobiety vs typ gminy

kk <-  subset(kx, (komitet == "PiS" ))
gminaP.pis.k <- ggplot(kk, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydatki PiS wg m. zamieszkania", subtitle="gmina miejska (m), wiejska (w), miejsko-wiejska (mw)") +
 ylab(label="%") +
 scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7), labels=c("10", "20", "30", "40", "50", "60", "70"), limits = c(0, 0.70)) +
 theme(plot.title = element_text(size=9))+
 theme(plot.subtitle = element_text(size=7))+
 geom_bar(aes(y = (..count..)/sum(..count..)), fill="steelblue")

#gminaP.pis.k

kk <-  subset(kx, (komitet == "SLD" ))

gmina.sld.k <- ggplot(kk, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydatki SLD wg m. zamieszkania") +
 ylab(label="N") +
 geom_bar(aes(x = typ), fill="steelblue")

#gmina.sld.k

gminaP.sld.k <- ggplot(kk, aes(x = typ)) +
 ggtitle("Sejm 2019: kandydatki SLD wg m. zamieszkania", subtitle="gmina miejska (m), wiejska (w), miejsko-wiejska (mw)") +
 ylab(label="%") +
 scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7), labels=c("10", "20", "30", "40", "50", "60", "70"), limits = c(0, 0.70)) +
 ## jeżeli za małe limits to nie wykreśla Removed 1 rows containing missing values (geom_bar)
 ## no dokładnie ten `bar' który jest za duży
 ##scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5), labels=c("10", "20", "30", "40", "50"), limits = c(0, 0.50)) +
 theme(plot.title = element_text(size=9))+
 theme(plot.subtitle = element_text(size=7))+
 geom_bar(aes(y = (..count..)/sum(..count..)), fill="steelblue")

#gminaP.sld.k

kk <-  subset(kx, (komitet == "PSL" ))
gminaP.psl.k <- ggplot(kk, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydatki PSL wg m. zamieszkania", subtitle="gmina miejska (m), wiejska (w), miejsko-wiejska (mw)") +
 ylab(label="%") +
 scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7), labels=c("10", "20", "30", "40", "50", "60", "70"), limits = c(0, 0.70)) +
 theme(plot.title = element_text(size=9))+
 theme(plot.subtitle = element_text(size=7))+
 geom_bar(aes(y = (..count..)/sum(..count..)), fill="steelblue")

kk <-  subset(kx, (komitet == "KOBW" ))
gminaP.kobw.k <- ggplot(kk, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydatki KO wg m. zamieszkania", subtitle="gmina miejska (m), wiejska (w), miejsko-wiejska (mw)") +
 ylab(label="%") +
 scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7), labels=c("10", "20", "30", "40", "50", "60", "70"), limits = c(0, 0.70)) +
 theme(plot.title = element_text(size=9))+
 theme(plot.subtitle = element_text(size=7))+
 geom_bar(aes(y = (..count..)/sum(..count..)), fill="steelblue")

#gminaP.pis.k 
#gminaP.sld.k
#gminaP.psl.k
#gminaP.kobw.k

#ggarrange( gminaP.pis.k, gminaP.sld.k, gminaP.psl.k, gminaP.kobw.k, ncol = 2, nrow = 2)

##
## komitety vs typ gminy (k+m)
kx <-  subset(k0, (komitet == "PiS" ))
gminaP.pis <- ggplot(kx, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydaci PiS wg m. zamieszkania", subtitle="gmina miejska (m), wiejska (w), miejsko-wiejska (mw)") +
 ylab(label="%") +
 theme(plot.title = element_text(size=9))+
 theme(plot.subtitle = element_text(size=7))+
 scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7), labels=c("10", "20", "30", "40", "50", "60", "70"), limits = c(0, 0.70)) +
 geom_bar(aes(y = (..count..)/sum(..count..)), fill="steelblue")
kx <-  subset(k0, (komitet == "SLD" ))
gminaP.sld <- ggplot(kx, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydaci SLD wg m. zamieszkania", subtitle="gmina miejska (m), wiejska (w), miejsko-wiejska (mw)") +
 ylab(label="%") +
 theme(plot.title = element_text(size=9))+
 theme(plot.subtitle = element_text(size=7))+
 scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7), labels=c("10", "20", "30", "40", "50", "60", "70"), limits = c(0, 0.70)) +
 geom_bar(aes(y = (..count..)/sum(..count..)), fill="steelblue")
kx <-  subset(k0, (komitet == "PSL" ))
gminaP.psl <- ggplot(kx, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydaci PSL wg m. zamieszkania", subtitle="gmina miejska (m), wiejska (w), miejsko-wiejska (mw)") +
 ylab(label="%") +
 theme(plot.title = element_text(size=9))+
 theme(plot.subtitle = element_text(size=7))+
 scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7), labels=c("10", "20", "30", "40", "50", "60", "70"), limits = c(0, 0.70)) +
 geom_bar(aes(y = (..count..)/sum(..count..)), fill="steelblue")
kx <-  subset(k0, (komitet == "KOBW" ))
gminaP.kobw <- ggplot(kx, aes(x = typ)) + 
 ggtitle("Sejm 2019: kandydaci KO wg m. zamieszkania", subtitle="gmina miejska (m), wiejska (w), miejsko-wiejska (mw)") +
 ylab(label="%") +
 theme(plot.title = element_text(size=9))+
 theme(plot.subtitle = element_text(size=7))+
 scale_y_continuous(breaks=c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7), labels=c("10", "20", "30", "40", "50", "60", "70"), limits = c(0, 0.70)) +
 geom_bar(aes(y = (..count..)/sum(..count..)), fill="steelblue")

ggarrange(gminaP.pis, gminaP.sld, gminaP.psl, gminaP.kobw, 
          gminaP.pis.k, gminaP.sld.k, gminaP.psl.k, gminaP.kobw.k, ncol = 4, nrow = 2)
ggsave(file="sejm_kandydaci2019.pdf", width=12)
######################
