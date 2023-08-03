#!/usr/bin/env Rscript
library(R.utils)

if (length(commandArgs(TRUE)) != 1){
  stop("Usage: ./gmt_symbol_to_entrez.R Homo_sapiens.gene_info.gz\n")

if(commandArgs(TRUE) < 2){
    stop("Usage: ./task2.R Homo_sapiens.gene_info.gz\n")
}

Homo_sapiens.gene_info <- args[1]
output_file <- "genes_by_chromosome.pdf"

library(ggplot2)
library(dplyr)
library(stringr)


gene_info_file <- read.table(Homo_sapiens.gene_info, sep = '\t',header = F, skip = 2,quote='', comment='')

#removing rows containing ambiguous data
gene_info_file<-gene_info_file[!grepl("\\|", gene_info_file$V7),]
gene_info_file<-gene_info_file[!grepl("-", gene_info_file$V7),]

gene_info_file$V7 <- factor(gene_info_file$V7, levels=c(1:22, "X", "Y", "MT", "Un"))

#grouping the genes by each chromosome
genes_per_chromosome <- gene_info_file %>%
  group_by(V7) %>%
  summarise(number_genes = n())

pdf("testplot.pdf",width=7,height=5)
ggplot(genes_per_chromosome, aes(x = V7, y = number_genes)) +
  geom_bar(stat = "identity", fill = "azure4") +
  labs(title = "Number of genes in each chromosome",
       x = "Chromosomes",
       y = "Gene count") +
  theme(plot.title = element_text(hjust = 0.5)) #to make the title in center
dev.off()

#Alternatively we can use ggsave also to save the plot

