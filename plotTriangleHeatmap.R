plotTriangleHeatmap<-function(matrixpvalue,results_overlap,output)
{

d_column <- dist(t(matrixpvalue), method = "euclidean") # distance matrix

fit_column <- hclust(d_column, method="centroid")


quantileHeight_column<-data.frame(quantile(fit_column$height))

df_quantile_height_column<-extractQuantile(quantileHeight_column)
fit_hclust_cut<-cutHclust(fit_column,dfclust=df_quantile_height_column)

##d_row<-dist(matrixpvalue,method="euclidean")
##fit_row<-hclust(d_row,method="centroid")

##k depends on the number of branch obsrved a priori

output1<-paste(output,"dendrogram_pvalue.pdf",sep="_")

pdf(output1,width=30,height=10)

        par(mar=c(30,5,5,5))

        d2=color_branches(fit_column,k=30)

        plot(d2)

dev.off()


###
### Correlation heatmap
###

results_overlap<-results_overlap[[3]]
	
n<-ncol(results_overlap[,c(6:ncol(results_overlap))])

tab_for_correlation<-results_overlap[,c(6:ncol(results_overlap))]
colnames(tab_for_correlation)<-tabinfofile[,2]

cor_results_overlap<-cor(tab_for_correlation,method="pearson")

cor_results_overlap[lower.tri (cor_results_overlap)] <- NA

color<-rev(brewer.pal(11, "Spectral"))
pairs.breaks<-c(-1,-0.50,-0.30,-0.10,-0.05,0,0.05,0.10,0.30,0.5,0.7,1)

output2<-paste(output,"correlation_heatmap.pdf",sep="_")

pdf(output2,width=20,height=20)
heatmap.2(cor_results_overlap, col=color,breaks=pairs.breaks, Rowv = NA, Colv = NA,scale="none",keysize = 0.5,density.info="none", trace="none",symkey=FALSE,cexRow=0.5,cexCol=0.5,margins =c(20,20))
dev.off()

cor_results_overlap<-cor(matrixpvalue,method="pearson")

#diag(cor_results_overlap) <- NA
cor_results_overlap[lower.tri (cor_results_overlap)] <- NA


color<-rev(brewer.pal(11, "Spectral"))
pairs.breaks<-c(-1,-0.50,-0.30,-0.10,-0.05,0,0.05,0.10,0.30,0.5,0.7,1)

output3<-paste(output,"pvalues_correlation_heatmap.pdf",sep="_")

pdf("pvalues_correlation_heatmap.pdf",width=20,height=20)
heatmap.2(cor_results_overlap, col=color,breaks=pairs.breaks, Rowv = NA, Colv = NA,scale="none",keysize = 0.5,density.info="none", trace="none",symkey=FALSE,cexRow=0.5,cexCol=0.5,margins =c(20,20))
dev.off()

quantileHeight_column<-data.frame(quantile(fit_column$height))
#quantileHeight_row<-data.frame(quantile(fit_row$height))


#create a matrix for the stratification of p-values, useful during clustering
##The follow code is to update
##
dfclust<-data.frame()

for(c in 1:nrow(quantileHeight_column)){

	if(c+1 <=nrow(quantileHeight_column))

	{


	dfrow<-data.frame(quantileHeight_column[c,1],quantileHeight_column[c+1,1])
	
	dfclust<-rbind(dfclust,dfrow)

	}


}

return(dfclust)

}
