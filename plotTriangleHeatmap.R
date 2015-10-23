plotTriangleHeatmap<-function(matrixpvalue,output)
{

d_column <- dist(t(matrixpvalue), method = "euclidean") # distance matrix
fit_column <- hclust(d_column, method="centroid")

##d_row<-dist(matrixpvalue,method="euclidean")
##fit_row<-hclust(d_row,method="centroid")

##k depends on the number of branch obsrved a priori

output1<-paste(output,"dendrogram_pvalue.pdf")

pdf(output1,width=30,height=10)

        par(mar=c(30,5,5,5))

        d2=color_branches(fit_column,k=30)

        plot(d2)

dev.off()


###
### Correlation heatmap
###
n<-ncol(results_overlap[nozero,c(6:ncol(results_overlap))])

tab_for_correlation<-results_overlap[nozero,c(6:ncol(results_overlap))]
colnames(tab_for_correlation)<-tabinfofile[,2]

cor_results_overlap<-cor(tab_for_correlation,method="pearson")

cor_results_overlap[lower.tri (cor_results_overlap)] <- NA

color<-rev(brewer.pal(11, "Spectral"))
pairs.breaks<-c(-1,-0.50,-0.30,-0.10,-0.05,0,0.05,0.10,0.30,0.5,0.7,1)

output2<-paste(output,"correlation_heatmap.pdf")

pdf(output2,width=20,height=20)
heatmap.2(cor_results_overlap, col=color,breaks=pairs.breaks, Rowv = NA, Colv = NA,scale="none",keysize = 0.5,density.info="none", trace="none",symkey=FALSE,cexRow=0.5,cexCol=0.5,margins =c(20,20))
dev.off()

cor_results_overlap<-cor(matrixpvalue,method="pearson")

#diag(cor_results_overlap) <- NA
cor_results_overlap[lower.tri (cor_results_overlap)] <- NA


color<-rev(brewer.pal(11, "Spectral"))
pairs.breaks<-c(-1,-0.50,-0.30,-0.10,-0.05,0,0.05,0.10,0.30,0.5,0.7,1)

output3<-paste(output,"pvalues_correlation_heatmap.pdf")

pdf("pvalues_correlation_heatmap.pdf",width=20,height=20)
heatmap.2(cor_results_overlap, col=color,breaks=pairs.breaks, Rowv = NA, Colv = NA,scale="none",keysize = 0.5,density.info="none", trace="none",symkey=FALSE,cexRow=0.5,cexCol=0.5,margins =c(20,20))
dev.off()

quantileHeight_column<-data.frame(quantile(fit_column$height))
#quantileHeight_row<-data.frame(quantile(fit_row$height))


#create a matrix for the stratification of p-values, useful during clustering

dfclust<-data.frame()

for(c in 1:nrow(quantileHeight)){

	if(c+1 <=nrow(quantileHeight))

	{


	dfrow<-data.frame(quantileHeight[c,1],quantileHeight[c+1,1])
	
	dfclust<-rbind(dfclust,dfrow)

	}


}

return(dfclust)

}

