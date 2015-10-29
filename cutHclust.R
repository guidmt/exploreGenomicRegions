cutHclust<-function(fit,dfclust){

list_save_hclust<-list(1:nrow(dfclust))

for(i in 1:nrow(dfclust)){

fit_object<-list(1:7)

subset_row<-which(fit$height>=dfclust[i,1]& fit$height<dfclust[i,2])

fit_object[[1]]<-fit$merge[subset_row,]
fit_object[[2]]<-fit$height[subset_row]
fit_object[[3]]<-fit$order[subset_row]
fit_object[[4]]<-fit$labels[subset_row]
fit_object[[5]]<-fit$method
fit_object[[6]]<-fit$call
fit_object[[7]]<-fit$dist.method

class(fit_object)<-"hclust"

list_save_hclust[[i]]<-fit_object

}

return(list_save_hclust)

}

