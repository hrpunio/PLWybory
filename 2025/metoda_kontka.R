library('tidyverse')
library("knitr")

p25_r2 <- read.csv("protokoly_po_obwodach_w_drugiej_turze_utf8.csv",
                   sep = ';', dec='.',
                   colClasses = c('Teryt.Gminy'= 'character' ),
                   header=TRUE,
                   ##skip=1,
                   na.string="NA" ) |>
  select( nrk=Nr.komisji,
          gmina=Gmina, 
          teryt=Teryt.Gminy, 
          siedziba=Siedziba, 
          lgw=Liczba.głosów.ważnych.oddanych.łącznie.na.obu.kandydatów..z.kart.ważnych.,
          nawrocki=NAWROCKI.Karol.Tadeusz,
          trzaskowski=TRZASKOWSKI.Rafał.Kazimierz ) |>
  ## Poprawiamy teryt
  mutate(teryt = ifelse( nchar(teryt) == 5, sprintf ("0%s", teryt), teryt)) |>
  mutate ( rr =  nawrocki + trzaskowski,
           nawrocki.p = nawrocki/rr *100,
           trzaskowski.p = trzaskowski/rr *100  ) |>
  mutate ( nrk = sprintf("%s.%03i", teryt, nrk)) |>
  select(nrk, teryt, siedziba,
         nawrocki2=nawrocki, trzaskowski2=trzaskowski, 
         nawrocki.p2=nawrocki.p, trzaskowski.p2=trzaskowski.p, lgw2=lgw) |>
  ## kolumna z kodem pocztowym:
  mutate ( pkod = str_extract(siedziba, "\\b\\d{2}-\\d{3}\\b"))

## Tylko Sopot
sopot_r2 <- p25_r2 |>  filter (teryt == '226401')

me <- median(sopot_r2$nawrocki.p2)
mad <- mad(sopot_r2$nawrocki.p2)

sopot_r2_00 <- sopot_r2 |>
  mutate (me = median(nawrocki.p2),
          mad = mad(nawrocki.p2),
          k = (nawrocki.p2 - me) /mad
  ) |>
  #filter (k > 2) |>
  arrange (-k) |>
  select(siedziba, lgw2, `gangus&sutener`=nawrocki.p2, me, mad, k)

##
##Po zastosowaniu procedury Kontka mamy:
##mediana = `r round(me, 2)`% dla KN (wiadomo elita głosuje na tego kogo trzeba:-))
##mad = `r round(mad, 2)`%.
##
##Dla dwóch komisji $k > 3$ (w tabeli dwa górne wiersze), czyli tam oszukali:
  
knitr::kable(sopot_r2_00, booktabs = TRUE, digits = 2)

