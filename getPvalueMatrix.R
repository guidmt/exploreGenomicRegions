getPvalueMatrix<-function(results_overlap,tabinfofile){

subtab_for_pvalue<-results_overlap[,6:ncol(results_overlap)]

#i want only a binary matrix with zero and one this because during the conversion with the p-value the script can have problem to manage the substitution of gsub

subtab_for_pvalue<-subtab_for_pvalue/subtab_for_pvalue

subtab_for_pvalue[is.na(subtab_for_pvalue)]<-0

for(c in 1:ncol(subtab_for_pvalue)){
print(c)
select_pvalue<-vector_pvalue[c]
        #change the presence with the p-values
        subtab_for_pvalue[,c]<-gsub(subtab_for_pvalue[,c],pattern="1",replacement=select_pvalue,fixed=T)
        subtab_for_pvalue[,c]<-as.numeric(subtab_for_pvalue[,c])
}


matrixpvalue<-as.matrix(subtab_for_pvalue)

colnames(matrixpvalue)<-tabinfofile[,2]

return(matrixpvalue)

}
