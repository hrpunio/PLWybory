komitety: komitetyR komitetyC

glosy: glosyR glosyC

komitetyR:
	R CMD BATCH rozklady_komitety.R
	mv Rplots.pdf rozklady_komitety.pdf
komitetyC:
	#convert -flatten -density 300 rozklady_komitety.pdf rozklady_komitety.png
	convert -density 300 rozklady_komitety.pdf rozklady_komitety_2014.jpg
	

glosyR:
	R CMD BATCH rozklady_glosy_niewazne.R
	mv Rplots.pdf rozklady_glosy_niewazne.pdf
glosyC:
	#convert -flatten -density 300 rozklady_glosy_niewazne.pdf rozklady_glosy_niewazne.png
	convert -density 300 rozklady_glosy_niewazne.pdf rozklady_glosy_niewazne_2014.jpg

copyPO:
	touch rozklady_komitety_2014-{2,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51}.jpg

clean:
	rm *.png

