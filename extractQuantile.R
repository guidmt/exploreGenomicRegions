extractQuantile<-function(quantileHeight){

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


