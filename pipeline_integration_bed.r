setwd("/media/data_disk/script_utility/exploreGenomicRegions")
library(rtracklayer)
library(regioneR)
library(BSgenome.Mmusculus.UCSC.mm9)
require(RColorBrewer)
library('dendextend')

source("loadBedFile.R")
source("getPvalueMatrix.R")
source("plotTriangleHeatmap.R")
source("extractQuantile.R")
source("cutHclust.R")

setwd("/media/data_disk/script_utility")

results_overlap<-loadBedFile(sampleinfo_file="sampleinfo_file_integrationbed_example.txt",reference_tab="Carninci_Mm3_CAGE_NAST.txt", dir_reference_tab="/media/data_disk/repbase_analysis/NAST_carninci/",dir_files_bed="/media/data_disk/atlas_mouse_data/compendium_for_repetitiveelements_analysis",genome="mm9",perm_number=1,output_file="test_integration",output_dir="/media/data_disk/script_utility/exploreGenomicRegions")

matrixpvalue<-getPvalueMatrix(results_overlap=results_overlap,tabinfofile=tabinfofile)

clustering<-plotTriangleHeatmap(matrixpvalue=matrixpvalue,results_overlap=results_overlap,output="test")
