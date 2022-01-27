all:
	R CMD BATCH pgnw_correlations.R
	mv Rplots.pdf pgnw_correlations.pdf
convert:
	convert -flatten -density 300 pgnw_correlations.pdf pgnw_correlations.png
	
