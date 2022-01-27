k <- read.csv("komisje-frek-areszty-zk-2015.csv", sep = ';',  header=T, na.string="NA");



#boxplot (glosy ~ komitet, k, xlab = "Komitet", ylab = "L.glosów", col = "yellow")

fivenum(k$PiSp)
mean(k$PiSp)

fivenum(k$POp)
mean(k$POp)

