#!/usr/bin/env Rscript
library(R.utils)

if(commandArgs(TRUE) < 2){
    stop("Usage: gmt_symbol_to_entrez.R h.all.v2023.1.Hs.symbols.gmt Homo_sapiens.gene_info.gz\n")
}

Homo_sapiens.gmt <- args[1]
Homo_sapiens.gene_info <- args[2]
output_file <- "gmt_entrez.gmt"

install.packages("GSA")

library("GSA")

gmt_old <- GSA.read.gmt(paste(gmt_file1,"h.all.v2023.1.Hs.symbols.gmt", sep = "/" ))
gene_info_file <- read.table(Homo_sapiens.gene_info, sep = '\t',header = F, skip = 2,quote='', comment='')

map_id <- list()

for (i in 1:nrow(gene_info_file)) {
  Entrez_id <- gene_info_file[[2]]
  Symbol <- gene_info_file[[3]]

}

Synonym <- strsplit(gene_info_file[[5]], "|", fixed=TRUE)


map_id <- data.frame(Symbol = character(), EntrezID = character(), stringsAsFactors = FALSE)

#Adding symbols to map table
for (i in seq_len(nrow(gene_info_file))) {
  Entrez_id <- gene_info_file$V2[[i]]
  Symbol <- gene_info_file$V3[[i]]
  map_id <- rbind(symbol_to_entrez_table, data.frame(Symbol = Symbol, EntrezID = Entrez_id, stringsAsFactors = FALSE))
}

#adding synonyms to map table
for (i in seq_along(Synonym)) {
  symbol <- Synonym[i]
  Entrez_id <- gene_info_file$V2[i]
  for (synonym in symbol) {
    map_id <- rbind(map_id, data.frame(Symbol = synonym, EntrezID = Entrez_id, stringsAsFactors = FALSE))
  }
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

 