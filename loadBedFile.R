loadBedFile<-function(sampleinfo_file,reference_tab, dir_reference_tab, dir_files_bed,perm_number,output_file)


        tabinfofile<-read.delim(file=sampleinfo_file)

        setwd(dir_reference_tab)

        tab_reference<-read.table(file=reference_tab,sep="\t",stringsAsFactors=FALSE,header=FALSE)
 
        db <- GRanges(tab_reference[,1], ranges = IRanges(tab_reference[,2], tab_reference[,3],names=tab_reference[,10]))

        setwd(dir_files_bed)

        list_file<-grep(dir(),pattern=".bed",value=T,invert=T)

        results_overlap<-data.frame(nrow=1:nrow(tab_reference))

        vector_pvalue<-NULL
        vector_zscore<-NULL
        length_overlap<-NULL

        for(i in list_file){

        print(i)

        tab2<-read.table(file=i,sep="\t",stringsAsFactors=FALSE,header=FALSE)

        IRange.reads=GRanges(seqnames=Rle(tab2[,1]),ranges=IRanges(tab2[,2], tab2[,3]))

        counts.RNAseq=data.frame(countOverlaps(db, IRange.reads))

        results_overlap<-cbind(results_overlap,counts.RNAseq[,1])

        pt <- overlapPermTest(A=tab_a, B=tab2,genome=genome,ntimes=perm_number, verbose=TRUE,non.overlapping=FALSE)

        vector_pvalue<-c(vector_pvalue,pt$pval)
        vector_zscore<-c(vector_zscore,pt$zscore)
        length_overlap<-c(length_overlap,pt$observed)
        
        print(pt$observed)

	results_overlap[,1]<-tab_reference[,10]

	results_overlap<-data.frame(results_overlap[,1],tab_reference[,11],results_overlap[,c(2:ncol(results_overlap))])

	colnames(results_overlap)<-c("name.rep","type.rep",list_file)

	results_overlap<-data.frame(tab_reference[,c(1:3)],results_overlap)
	
	output1<-paste(output_file,".txt",sep="")
	
	write.table(results_overlap,file=output1,sep="\t",row.names=FALSE,quote=FALSE,col.names=TRUE)

	nozero<- which(rowSums(results_overlap[,c(6:ncol(results_overlap))])!=0)

        output2<-paste(output_file,".nozero.txt",sep="")

	write.table(results_overlap[nozero,],file=output2,sep="\t",row.names=F,quote=F,col.names=T)

	nozero2<- which(rowSums(results_overlap[,c(6:ncol(results_overlap))])>2)

	output3<- paste(output_file,sep=".nozero.over2bind.txt",sep="")

	write.table(results_overlap[nozero2,],file=output3,sep="\t",row.names=FALSE,quote=FALSE,col.names=TRUE)

	output4<-paste(output_file,".Rdata",sep="")

	rownames(results_overlap)<-results_overlap[,5]

save.image(output4)

return(results_overlap)

}

