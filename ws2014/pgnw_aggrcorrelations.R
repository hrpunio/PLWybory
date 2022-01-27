## 
d <- read.csv("powiaty_korelacje_pgnw_poparcie.csv", sep = ';',  header=T, na.string="NA");

summary(d$pgnw);
fivenum(d$pgnw);
