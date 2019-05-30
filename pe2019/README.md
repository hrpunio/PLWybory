# Wybory do PE 2019

Dane z pkw.gov.pl (27277 komisji obwodowych)
Pominięto listę nr 8 wykreśloną przed wyborami

Z pliku obwody_glosowania.csv (ze strony https://wybory.gov.pl/) skopiowano kolumnę 'teryt gminy'
następnie pobrano pliki wg schematu:
https://wybory.gov.pl/pe2019/pl/wyniki/gm/TERYT_GMINY

Z plików tych wyciągnięto identyfiaktory komisji obwodowych
(wartości atrybutu data-id w elemencie div z atrybutem proto).
Tych identyfiaktarów jest 27277 (co jest wartością równą podanej 
na stronie https://wybory.gov.pl/pe2019/pl/organy_wyborcze/obwodowe/pl)


id = id komisji obwodowej https://wybory.gov.pl/pe2019/pl/wyniki/protokol/**id**

teryt = numer teryt

nrk = numer komisji (teryt+nrk jest unikatowe)

nzl = nazwa listy

nr = numer na liście

kto = imię i nazwisko

glosy = liczba głosów
