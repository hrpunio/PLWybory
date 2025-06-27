library("tidyverse")
library("ggpubr")
setwd("~/Projekty/PKW/2025")

spanV <- 0.5
min_lgw <- 49

## PKW spierniczyła Teryt w 2023/2024 roku ############################

p25 <- read.csv("protokoly_po_obwodach_utf8.csv",
		 sep = ';', dec='.',
		 colClasses = c('Teryt.Gminy'= 'character' ),
     header=TRUE,
		 ##skip=1,
		 na.string="NA" ) |>
select( "nrk"="Nr.komisji",
`gmina`=`Gmina`, 
`teryt`=`Teryt.Gminy`, 
`powiat`=`Powiat`, 
`powiat.teryt`=`Teryt.Powiatu`, 
`woj`=`Województwo`, 
`siedziba`=`Siedziba`, 
`lkart.otrzymanych`=`Liczba.kart.do.głosowania.otrzymanych.przez.obwodową.komisję.wyborczą..ustalona.po.ich.przeliczeniu.przed.rozpoczęciem.głosowania.z.uwzględnieniem.ewentualnych.kart.otrzymanych.z.rezerwy`,
`l.wyborcow.upr`=`Liczba.wyborców.uprawnionych.do.głosowania..umieszczonych.w.spisie..z.uwzględnieniem.dodatkowych.formularzy..w.chwili.zakończenia.głosowania`,
`l.kart.niewyk`=`Liczba.niewykorzystanych.kart.do.głosowania`,
lwkwk=`Liczba.wyborców..którym.wydano.karty.do.głosowania.w.lokalu.wyborczym..liczba.podpisów.w.spisie.oraz.adnotacje.o.wydaniu.karty.bez.potwierdzenia.podpisem.w.spisie.`,
`l.pakiety`=`Liczba.wyborców..którym.wysłano.pakiety.wyborcze`,
`l.x1`=`Liczba.wyborców..którym.wydano.karty.do.głosowania.w.lokalu.wyborczym.oraz.w.głosowaniu.korespondencyjnym..łącznie.`,
`l.x2`=`Liczba.wyborców.głosujących.przez.pełnomocnika..liczba.kart.do.głosowania.wydanych.na.podstawie.aktów.pełnomocnictwa.otrzymanych.przez.obwodową.komisję.wyborczą.`,
`l.x3`=`Liczba.wyborców.głosujących.na.podstawie.zaświadczenia.o.prawie.do.głosowania`,
`l.x4`=`Liczba.otrzymanych.kopert.zwrotnych.w.głosowaniu.korespondencyjnym`,
`l.x5`=`Liczba.kopert.zwrotnych.w.głosowaniu.korespondencyjnym..w.których.nie.było.oświadczenia.o.osobistym.i.tajnym.oddaniu.głosu`,
`l.x6`=`Liczba.kopert.zwrotnych.w.głosowaniu.korespondencyjnym..w.których.oświadczenie.nie.było.podpisane.przez.wyborcę`,
`l.x7`=`Liczba.kopert.zwrotnych.w.głosowaniu.korespondencyjnym..w.których.nie.było.koperty.na.kartę.do.głosowania`,
`l.kopert.x`=`Liczba.kopert.zwrotnych.w.głosowaniu.korespondencyjnym..w.których.znajdowała.się.niezaklejona.koperta.na.kartę.do.głosowania`,
`l.kopert`=`Liczba.kopert.na.kartę.do.głosowania.w.głosowaniu.korespondencyjnym.wrzuconych.do.urny`,
`lk`=`Liczba.kart.wyjętych.z.urny`,
`lk.gk`=`w.tym.liczba.kart.wyjętych.z.kopert.na.kartę.do.głosowania.w.głosowaniu.korespondencyjnym`,
`lknw`=`Liczba.kart.nieważnych..bez.pieczęci.obwodowej.komisji.wyborczej.lub.inne.niż.urzędowo.ustalone.`,
`lkw`=`Liczba.kart.ważnych`,
`lgnw`=`Liczba.głosów.nieważnych..z.kart.ważnych.`,
`lgnw.x`=`w.tym.z.powodu.postawienia.znaku..X..obok.nazwiska.dwóch.lub.większej.liczby.kandydatów`,
`lgnw.no.x`=`w.tym.z.powodu.niepostawienia.znaku..X..obok.nazwiska.żadnego.kandydata`,
`lgnw.no.z`=`w.tym.z.powodu.postawienia.znaku..X..wyłącznie.obok.nazwiska.skreślonego.kandydata`,
`lgw`=`Liczba.głosów.ważnych.oddanych.łącznie.na.wszystkich.kandydatów..z.kart.ważnych.`,
`bartoszewicz`=`BARTOSZEWICZ.Artur`,
`biejat`=`BIEJAT.Magdalena.Agnieszka`,
`braun`=`BRAUN.Grzegorz.Michał`,
`holownia`=`HOŁOWNIA.Szymon.Franciszek`,
`jakubiak`=`JAKUBIAK.Marek`,
`maciak`=`MACIAK.Maciej`,
`mentzen`=`MENTZEN.Sławomir.Jerzy`,
`nawrocki`=`NAWROCKI.Karol.Tadeusz`,
`senyszyn`=`SENYSZYN.Joanna`,
`stanowski`=`STANOWSKI.Krzysztof.Jakub`,
`trzaskowski`=`TRZASKOWSKI.Rafał.Kazimierz`,
`woch`=`WOCH.Marek.Marian`,
`zandberg`=`ZANDBERG.Adrian.Tadeusz` ) |>
  mutate ( rr0 = nawrocki + trzaskowski,
           rr = bartoszewicz + biejat + braun + holownia + jakubiak + maciak + mentzen + nawrocki +
             senyszyn + stanowski + trzaskowski + woch + zandberg,
           bb = lgw - rr,
           ##
           nawrocki.p = nawrocki/rr *100,
           trzaskowski.p = trzaskowski/rr *100,
           tnr1 = trzaskowski / (trzaskowski + nawrocki),
           frek1 = lkw/l.wyborcow.upr
           ) |>
  mutate ( nrk = sprintf("%s.%03i", teryt, nrk)) |>
  select(nrk, gmina, teryt, siedziba, nawrocki, trzaskowski,
         lwkwk, l.wyborcow.upr, lkw, frek1,
         nawrocki.p, trzaskowski.p, tnr1, lgw)

#
p25_r2 <- read.csv("protokoly_po_obwodach_w_drugiej_turze_utf8.csv",
                sep = ';', dec='.',
                colClasses = c('Teryt.Gminy'= 'character' ),
                header=TRUE,
                ##skip=1,
                na.string="NA" ) |>
  select( "nrk"="Nr.komisji",
          `gmina`=`Gmina`, 
          `teryt`=`Teryt.Gminy`, 
          `powiat`=`Powiat`, 
          `powiat.teryt`=`Teryt.Powiatu`, 
          `woj`=`Województwo`, 
          `siedziba`=`Siedziba`, 
          `lkart.otrzymanych`=`Liczba.kart.do.głosowania.otrzymanych.przez.obwodową.komisję.wyborczą..ustalona.po.ich.przeliczeniu.przed.rozpoczęciem.głosowania.z.uwzględnieniem.ewentualnych.kart.otrzymanych.z.rezerwy`,
          `l.wyborcow.upr`=`Liczba.wyborców.uprawnionych.do.głosowania..umieszczonych.w.spisie..z.uwzględnieniem.dodatkowych.formularzy..w.chwili.zakończenia.głosowania`,
          `l.kart.niewyk`=`Liczba.niewykorzystanych.kart.do.głosowania`,
          lwkwk=`Liczba.wyborców..którym.wydano.karty.do.głosowania.w.lokalu.wyborczym..liczba.podpisów.w.spisie.oraz.adnotacje.o.wydaniu.karty.bez.potwierdzenia.podpisem.w.spisie.`,
          `l.pakiety`=`Liczba.wyborców..którym.wysłano.pakiety.wyborcze`,
          `l.x1`=`Liczba.wyborców..którym.wydano.karty.do.głosowania.w.lokalu.wyborczym.oraz.w.głosowaniu.korespondencyjnym..łącznie.`,
          `l.x2`=`Liczba.wyborców.głosujących.przez.pełnomocnika..liczba.kart.do.głosowania.wydanych.na.podstawie.aktów.pełnomocnictwa.otrzymanych.przez.obwodową.komisję.wyborczą.`,
          `l.x3`=`Liczba.wyborców.głosujących.na.podstawie.zaświadczenia.o.prawie.do.głosowania`,
          `l.x4`=`Liczba.otrzymanych.kopert.zwrotnych.w.głosowaniu.korespondencyjnym`,
          `l.x5`=`Liczba.kopert.zwrotnych.w.głosowaniu.korespondencyjnym..w.których.nie.było.oświadczenia.o.osobistym.i.tajnym.oddaniu.głosu`,
          `l.x6`=`Liczba.kopert.zwrotnych.w.głosowaniu.korespondencyjnym..w.których.oświadczenie.nie.było.podpisane.przez.wyborcę`,
          `l.x7`=`Liczba.kopert.zwrotnych.w.głosowaniu.korespondencyjnym..w.których.nie.było.koperty.na.kartę.do.głosowania`,
          `l.kopert.x`=`Liczba.kopert.zwrotnych.w.głosowaniu.korespondencyjnym..w.których.znajdowała.się.niezaklejona.koperta.na.kartę.do.głosowania`,
          `l.kopert`=`Liczba.kopert.na.kartę.do.głosowania.w.głosowaniu.korespondencyjnym.wrzuconych.do.urny`,
          `lk`=`Liczba.kart.wyjętych.z.urny`,
          `lk.gk`=`w.tym.liczba.kart.wyjętych.z.kopert.na.kartę.do.głosowania.w.głosowaniu.korespondencyjnym`,
          `lknw`=`Liczba.kart.nieważnych..bez.pieczęci.obwodowej.komisji.wyborczej.lub.inne.niż.urzędowo.ustalone.`,
          `lkw`=`Liczba.kart.ważnych`,
          `lgnw`=`Liczba.głosów.nieważnych..z.kart.ważnych.`,
          ##
          `lgnw.x`=`w.tym.z.powodu.postawienia.znaku..X..obok.nazwisk.obu.kandydatów`,
          `lgnw.no.x`=`w.tym.z.powodu.niepostawienia.znaku..X..obok.nazwiska.żadnego.kandydata`,
          ##
          ##`lgnw.no.z`=`w.tym.z.powodu.postawienia.znaku..X..wyłącznie.obok.nazwiska.skreślonego.kandydata`,
          `lgw`=`Liczba.głosów.ważnych.oddanych.łącznie.na.obu.kandydatów..z.kart.ważnych.`,
          ##
          `nawrocki`=`NAWROCKI.Karol.Tadeusz`,
          `trzaskowski`=`TRZASKOWSKI.Rafał.Kazimierz` ) |>
  mutate ( rr =  nawrocki + trzaskowski,
           bb = lgw - rr,
           nawrocki.p = nawrocki/rr *100,
           trzaskowski.p = trzaskowski/rr *100,
           tnr2 = trzaskowski/(trzaskowski + nawrocki),
           frek2 = lkw/l.wyborcow.upr
  ) |>
  mutate ( nrk = sprintf("%s.%03i", teryt, nrk)) |>
  select(nrk, teryt, siedziba, lwkwk, l.wyborcow.upr, lkw, frek2,
         nawrocki2=nawrocki, tnr2, trzaskowski2=trzaskowski, nawrocki.p2=nawrocki.p, 
          trzaskowski.p2=trzaskowski.p, lgw2=lgw)

nrow(p25)
nrow(p25_r2)

p25_r2 |> filter ( lgw2 < 2000 ) |> nrow()

p25_r2_99 <- p25_r2 |> filter ( lgw2 < 100 )
nrow(p25_r2_99)
sum(p25_r2_99$lgw2)
sum(p25_r2_99$trzaskowski2)

##
## Frekwencja
## 67.31 (1t); 71.63 (2t)
head(p25)
lwk1 <- sum(p25$lwkwk, na.rm = T) 
lwu1 <- sum(p25$l.wyborcow.upr, na.rm=T)
lkw1 <- sum(p25$lkw, na.rm=T)
frek1 <- lwk1/lwu1
frek1
##
lwk2 <- sum(p25_r2$lwkwk, na.rm = T) 
lwu2 <- sum(p25_r2$l.wyborcow.upr, na.rm=T)
lkw2 <- sum(p25_r2$lkw, na.rm=T)
frek2 <- lkw2/lwu2
## 71.60 vs 71.63
## 29363322 vs 29363722
lwu2
frek2
lkw2

## 20844163
## drobna różnica
lgw2.sum <- sum(p25_r2$lgw2, na.rm=T)
t_lgw2.sum <- sum(p25_r2$trzaskowski2, na.rm=T)
n_lgw2.sum <- sum(p25_r2$nawrocki2, na.rm=T)

## 32143 komisje
## 31518 komisji gdzie lgw > 24 w obu turach
min_lgw <- 99
p00 <- left_join(p25, p25_r2, by='nrk')
t00 <- sum(p00$trzaskowski, na.rm = T)
t002 <- sum(p00$trzaskowski2, na.rm = T)

p <- p00 |>
  filter (lgw > min_lgw & lgw2 > min_lgw ) |>
  mutate (nawrocki.z = nawrocki2/nawrocki * 100 - 100,
          trzaskowski.z = trzaskowski2/trzaskowski * 100 - 100)

nrow(p)

sum(p$trzaskowski)/t00
sum(p$trzaskowski2)/t002

p0 <- p |> select (nrk, tnr1, tnr2, lgw, lgw2) |>
  filter (lgw > 99 & lgw2 > 99) |>
  ##pivot_longer(cols=c(tnr1, tnr2)) |>
  ggplot(aes(x=tnr1 * 100, y=tnr2 * 100)) +
  geom_point(alpha=.3, size=.5) +
  ylab('trzaskowski/nawrocki 2r') +
  xlab('trzaskowski/nawrocki 1r') +
  scale_x_continuous(limits = c(0, 100), breaks = seq(0, 100, by = 10)) +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, by = 10)) +
  geom_abline(intercept = 0, slope = 1, color = "green") +
  ggtitle('Wybory 2025: % zmiana poparcia wg obwodowych komisji wyborczych',
          subtitle='Pominięto komisje, w których oddano 99 głosy lub mniej')
  
p0
ggsave(p0, file='2025-trzaskowski-nawrocki.png')
##
p |> filter (lgw > 99 & lgw2 > 99) |> nrow()

p |> mutate (r = (tnr2 - tnr1) * 100 ) |> summarise (r = mean(r))

##
p |> filter (lgw > 99 & lgw2 > 99) |>
  filter (tnr1 - tnr2 < -0.1 | tnr1 - tnr2 > 0.1 ) |> nrow()


## Frekw
p$frek1

p2 <- p |> mutate (f = (frek2 - frek1) * 100 ) |>
  filter (lgw > 49 & lgw2 > 49) |>
  ggplot(aes(x=f )) +
  geom_histogram(binwidth = 2.5, alpha=.3, fill = "steelblue") +
  ylab('liczba komisji') +
  xlab('% poparcia (zmiana)') +
  #scale_x_continuous(limits = c(-50, 225), breaks = seq(-50, 225, by = 20)
  #) +
  #scale_y_continuous(limits = c(0, 2750), breaks = seq(0, 2750, by = 250)
  #) +
  ##geom_boxplot(color='red', outliers = FALSE) +
  ggtitle('% zmiana poparcia dla kandydata',
          subtitle='Pominięto komisje, w których oddano 49 głosy lub mniej')
p2

p2j <- p |> mutate (f = (frek2 - frek1) * 100 ) |>
  ggplot(aes(x='', y=f)) +
  geom_jitter(alpha=.3, size=.1, color='navyblue') +
  ylab('%') +
  xlab('') +
  ##geom_boxplot(color='red', outliers = FALSE) +
  ggtitle('% zmiana poparcia dla kandydatów wg obwodowych komisji wyborczych',
          subtitle='Pominięto komisje, w których oddano 99 głosy lub mniej')
p2j

nietypowa.frek <- p |> mutate (f = (frek2 - frek1) * 100 ) |>
  filter (f < -25 | f > 25)


p |> filter( tnr1 < tnr2 ) |> nrow()
p |> filter( tnr1 == tnr2) |> nrow()
p |> filter( tnr1 > tnr2) |> nrow()

p |> filter( tnr2 - tnr1 > 0.1) |> nrow()
p |> filter( tnr2 - tnr1 < -0.15) |> nrow()

zz <- p |> filter( tnr2 - tnr1 < -0.15)


## 31518 komisji gdzie lgw > 24 w obu turach
p.rest <- left_join(p25, p25_r2, by='nrk') |>
  filter (lgw <= min_lgw | lgw2 <= min_lgw ) |>
  summarise( n = sum(nawrocki2, na.rm=T), 
                     t = sum(trzaskowski2, na=T))
## W tych okręgach:
## 56068 N
## 40958 T
## % głosów na N jako % wszystkich głosów ważnych
p.rest$n
p.rest$n/lgw2.sum * 100
## 15,1% różnicy głosów pomiędzy N a T
##
##
p0 <- p |> select (nrk, nawrocki.z, trzaskowski.z) |>
  pivot_longer(cols=c(nawrocki.z, trzaskowski.z)) |>
  ggplot(aes(x=name, y=value)) +
  geom_jitter(alpha=.3, size=.1, color='navyblue') +
  ylab('%') +
  xlab('') +
  ##geom_boxplot(color='red', outliers = FALSE) +
  ggtitle('% zmiana poparcia dla kandydatów wg obwodowych komisji wyborczych',
          subtitle='Pominięto komisje, w których oddano 99 głosy lub mniej')
p0
##
###
max_increase <- 250
min_increase <- 10

p_h <- p |> filter (nawrocki.z > max_increase | trzaskowski.z > max_increase ) |>
  filter (lgw > min_lgw & lgw2 > min_lgw ) |>
  select (nrk, teryt, siedziba, nawrocki, nawrocki2, nawrocki.z, trzaskowski, trzaskowski2, trzaskowski.z)
p_l <- p |> filter (nawrocki.z < min_increase | trzaskowski.z < min_increase  ) |>
  filter (lgw > min_lgw & lgw2 > min_lgw ) |>
  select (nrk, teryt, siedziba, nawrocki, nawrocki2, nawrocki.z, trzaskowski, trzaskowski2, trzaskowski.z)

p_h_l <- bind_rows(p_h, p_l)


q <- p |> select (nrk, nawrocki.z, trzaskowski.z, lgw2, nawrocki2, trzaskowski2) |>
  filter (nawrocki.z <= 250 & trzaskowski.z <= 250) 

nrow(q)
sum(q$lgw2)
t2_lgw <- sum(q$trzaskowski2)
n2_lgw <- sum(q$nawrocki2)
##
t_lgw2.sum - t2_lgw
n_lgw2.sum - n2_lgw

p2 <- q |> pivot_longer(cols = c(nawrocki.z, trzaskowski.z)) |>
  ggplot(aes(x=value, fill=name )) +
  geom_histogram(binwidth = 2.5, alpha=.3) +
  ylab('liczba komisji') +
  xlab('% poparcia (zmiana)') +
  scale_x_continuous(limits = c(-50, 225), breaks = seq(-50, 225, by = 20)
                     ) +
  scale_y_continuous(limits = c(0, 2750), breaks = seq(0, 2750, by = 250)
  ) +
  ##geom_boxplot(color='red', outliers = FALSE) +
  ggtitle('% zmiana poparcia dla kandydata',
          subtitle='Pominięto komisje, w których oddano 49 głosy lub mniej')
p2

## Histogram
very_high <- p_h_l |> #select (nrk, nawrocki.z, trzaskowski.z) |>
  pivot_longer(cols=c(nawrocki.z, trzaskowski.z)) |>
  filter (value > 1000)


p1 <- p_h_l |> select (nrk, nawrocki.z, trzaskowski.z) |>
  #pivot_longer(cols=c(nawrocki.z, trzaskowski.z)) |>
  filter (nawrocki.z <= 1000 & trzaskowski.z <= 1000) |>
  ggplot(aes(x=nawrocki.z, y=trzaskowski.z)) +
  geom_point(alpha=.3, size=.4, color='navyblue') +
  ##ylab('%') +
  ##xlab('') +
  ##geom_boxplot(color='red', outliers = FALSE) +
  ggtitle('% zmiana poparcia dla kandydata',
          subtitle='Pominięto komisje, w których oddano 99 głosy lub mniej')
p1

nawrocki.h <- p_h_l |> #select (nrk, nawrocki.z, trzaskowski.z) |>
  #pivot_longer(cols=c(nawrocki.z, trzaskowski.z)) |>
  filter (nawrocki.z >= 250 & nawrocki.z <= 500 & trzaskowski.z < 250 & trzaskowski.z > 0)
sum(nawrocki.h$nawrocki2)

trzaskowski.h <- p_h_l |> #select (nrk, nawrocki.z, trzaskowski.z) |>
  #pivot_longer(cols=c(nawrocki.z, trzaskowski.z)) |>
  filter (trzaskowski.z >= 250 & trzaskowski.z <= 500 & nawrocki.z < 250 & nawrocki.z > 0)
sum(trzaskowski.h$trzaskowski2)
trzaskowski.h 

### p25_r2
### Gdańsk
g2 <- p25_r2 |> filter (teryt == '226101') 
##
nrow(g2)
