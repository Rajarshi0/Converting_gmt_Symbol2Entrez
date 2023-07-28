#!/usr/bin/env Rscript
library(R.utils)

if(commandArgs(TRUE) < 2){
    stop("Usage: gmt_symbol_to_entrez.R h.all.v2023.1.Hs.symbols.gmt Homo_sapiens.gene_info.gz\n")
}

Homo_sapiens.gmt <- args[1]
Homo_sapiens.gene_info <- args[2]
output_file <- "gmt_entrez.gmt"


load.libs <- c( "DOSE", "GO.db","GSEABase", "org.Hs.eg.db")
options(install.packages.check.source = "no")
options(install.packages.compile.from.source = "never")
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(load.libs, update = TRUE, character.only = TRUE)
status <- sapply(load.libs,require,character.only = TRUE)
if(all(status)){
  print("SUCCESS: You have successfully installed and loaded all required libraries.")
} else{
  cat("ERROR: One or more libraries failed to install correctly. Check the following list for FALSE cases and try again...\n\n")
  status
}

install.packages("GSA")

library("GSA")
library("AnnotationDbi")
library("org.Hs.eg.db")

#using publicc databases like AnnotationDbi and org.Hs.eg.db 


gmt_old <- GSA.read.gmt(paste(gmt_file1,"h.all.v2023.1.Hs.symbols.gmt", sep = "/" ))
gene_info_file <- read.table(Homo_sapiens.gene_info, sep = '\t',header = F, skip = 2,quote='', comment='')

for (x in 1:y) {
 gmt_new$genesets[[x]]<- mapIds(org.Hs.eg.db,
       keys=gmt_old$genesets[[x]],  #Column containing Ensembl gene ids
       column="ENTREZID",
       keytype="SYMBOL",
       multiVals="first")
}


write.table(gmt_new, file = output_file, sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)

tryCatch({
    gmt_old <- GSA.read.gmt(paste(gmt_file1,"h.all.v2023.1.Hs.symbols.gmt", sep = "/" ))
    gene_info_file <- read.table(Homo_sapiens.gene_info, sep = '\t',header = F, skip = 2,quote='', comment='')

    write.table(gmt_new, file = output_file, sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)
    cat("GMT file processed successfully. Modified GMT file saved as 'gmt_entrez.gmt'.\n")
    }, error = function(e) {
   cat("Error occurred: ", conditionMessage(e), "\n")
})

 