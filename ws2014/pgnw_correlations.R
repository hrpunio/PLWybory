## Ocena zależności pomiędzy odsetkiem głosów nieważnych
## a uzyskanym wynikiem w wyborach samorządowych do sejmików wojewódzkich 2014
## 
require (ggplot2)
library(dplyr)

d <- read.csv("komisje_komitety7t_wyniki.csv", 
    colClasses = c( "teryt"="character", "adres"="character"),
    sep = ';',  header=T, na.string="NA");

##str(d);
summary(d$pgnw14);

## Tylko duże komisje tj takie gdzie wydano więcej niż 20 kart
## (małe komisje z reguły są `dziwne' -- jakieś zamknięte obwody itp)
d <- subset (d, ( lkw14 > 20 ));

## (% głosów oddanych na PSL/PiS/PO lgw14 = liczba głosów ważnych)
pslp <- d$psl/d$lgw14 * 100;
pisp <- d$pis/d$lgw14 * 100;
pop <- d$po/d$lgw14 * 100;

## Podsumowanie: 
summary(pslp)
summary(pisp)
summary(pop)

d[,"pslp"] <- pslp;
d[,"pisp"] <- pisp;
d[,"pop"] <- pop;

## Korelacje pomiędzy % głosów a % głosów niewaznych
## dla PSL/PO/PiS
cor(d$pgnw14, d$pslp, use = "complete")
cor(d$pgnw14, d$pisp, use = "complete")
cor(d$pgnw14, d$pop, use = "complete")

## Wykresy rozrzutu  ## ###
lm <- lm(data=d, pslp ~ pgnw14 ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("psl = %.2f pgnw + %.1f", lmc[2], lmc[1] );

ggplot(d, aes(x = pgnw14, y=pslp )) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="pgnw") +
  ylab(label="pslp") +
  geom_smooth(method = "lm", colour = 'black')

lm <- lm(data=d, pslp ~ freq ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("psl = %.2f freq + %.1f", lmc[2], lmc[1] );
ggplot(d, aes(x = freq, y=pslp )) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="freq") +
  ylab(label="pslp") +
  geom_smooth(method = "lm", colour = 'black')

lm <- lm(data=d, pisp ~ pgnw14 ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("pis = %.2f pgnw + %.1f", lmc[2], lmc[1] );

ggplot(d, aes(x = pgnw14 , y=pisp)) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="pgnw") +
  ylab(label="pisp") +
geom_smooth(method = "lm", colour = 'black')

lm <- lm(data=d, pisp ~ freq ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("pis = %.2f freq + %.1f", lmc[2], lmc[1] );

ggplot(d, aes(x = freq , y=pisp)) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="freq") +
  ylab(label="pisp") +
geom_smooth(method = "lm", colour = 'black')

lm <- lm(data=d, pop ~ pgnw14 ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("po = %.2f pgnw + %.1f", lmc[2], lmc[1] );

ggplot(d, aes(x = pgnw14, y=pop )) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="pgnw") +
  ylab(label="pop") +
  geom_smooth(method = "lm", colour = 'black')

lm <- lm(data=d, pop ~ freq ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("po = %.2f freq + %.1f", lmc[2], lmc[1] );

ggplot(d, aes(x = freq, y=pop )) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="freq") +
  ylab(label="pop") +
  geom_smooth(method = "lm", colour = 'black')
## ## ## W podziale na metropolie/prowincję 
du <- subset (d, subset=(typ == "U"));
## str(du)
summary(du$pgnw14);
summary(du$pslp)
summary(du$pisp)
summary(du$pop)

cor(du$pgnw14, du$pslp, use = "complete")
cor(du$pgnw14, du$pisp, use = "complete")
cor(du$pgnw14, du$pop, use = "complete")

lm <- lm(data=du, pslp ~ pgnw14 ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("psl = %.2f pgnw + %.1f", lmc[2], lmc[1] );

ggplot(du, aes(x = pgnw14, y=pslp )) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="pgnw") +
  ylab(label="pslp") +
  geom_smooth(method = "lm", colour = 'black')

lm <- lm(data=du, pslp ~ freq ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("psl = %.2f freq + %.1f", lmc[2], lmc[1] );
ggplot(du, aes(x = freq, y=pslp )) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="freq") +
  ylab(label="pslp") +
  geom_smooth(method = "lm", colour = 'black')

#### ####

lm <- lm(data=du, pisp ~ pgnw14 ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("pis = %.2f pgnw + %.1f", lmc[2], lmc[1] );

ggplot(du, aes(x = pgnw14 , y=pisp)) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="pgnw") +
  ylab(label="pisp") +
geom_smooth(method = "lm", colour = 'black')

lm <- lm(data=du, pop ~ pgnw14 ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("po = %.2f pgnw + %.1f", lmc[2], lmc[1] );

ggplot(du, aes(x = pgnw14, y=pop )) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="pgnw") +
  ylab(label="pop") +
  geom_smooth(method = "lm", colour = 'black')


dr <- subset (d, subset=(typ == "R"));
##str(dr)
summary(dr$pgnw14);
summary(dr$pslp)
summary(dr$pisp)
summary(dr$pop)

cor(dr$pgnw14, dr$pslp, use = "complete")
cor(dr$pgnw14, dr$pisp, use = "complete")
cor(dr$pgnw14, dr$pop, use = "complete")

lm <- lm(data=dr, pslp ~ pgnw14 ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("psl = %.2f pgnw + %.1f", lmc[2], lmc[1] );

ggplot(dr, aes(x = pgnw14, y=pslp )) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="pgnw") +
  ylab(label="pslp") +
  geom_smooth(method = "lm", colour = 'black')

lm <- lm(data=dr, pisp ~ pgnw14 ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("pis = %.2f pgnw + %.1f", lmc[2], lmc[1] );

ggplot(dr, aes(x = pgnw14 , y=pisp)) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="pgnw") +
  ylab(label="pisp") +
geom_smooth(method = "lm", colour = 'black')

lm <- lm(data=dr, pop ~ pgnw14 ); summary(lm)
lmc <- coef(lm);
title <- sprintf ("po = %.2f pgnw + %.1f", lmc[2], lmc[1] );

ggplot(dr, aes(x = pgnw14, y=pop )) +
  geom_point(colour = 'blue') +
  ggtitle(title) +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(label="pgnw") +
  ylab(label="pop") +
  geom_smooth(method = "lm", colour = 'black')


## ## ## Indywidualne wskaźniki w powiatach ## ## ##
## ## ## TERYT dla powiatu ## ## ##
powiat <- substr(d$teryt, 0, 4)

# http://stackoverflow.com/questions/16181750/correlation-of-subsets-of-dataframe-using-aggregate
d[,"powiat"] <- powiat;
p.psl <- d %>% group_by(powiat) %>% summarise(V1=cor(pgnw14,pslp))
p.pis <- d %>% group_by(powiat) %>% summarise(V1=cor(pgnw14,pis))
p.po  <- d %>% group_by(powiat) %>% summarise(V1=cor(pgnw14,po))

fivenum(p.psl$V1)
fivenum(p.pis$V1)
fivenum(p.po$V1)

print(p.psl, n=Inf)
print(p.pis, n=Inf)
print(p.po, n=Inf)

m.pgnw <- d %>% group_by(powiat) %>% summarise(V2=mean(pgnw14))
m.psl <- d %>% group_by(powiat) %>% summarise(V2=mean(pslp))
m.pis <- d %>% group_by(powiat) %>% summarise(V2=mean(pisp))
m.po <- d %>% group_by(powiat) %>% summarise(V2=mean(pop))

print(m.pgnw, n=Inf)
print(m.psl, n=Inf)
print(m.pis, n=Inf)
print(m.po, n=Inf)

