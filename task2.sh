#!/bin/bash 
wget https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa
sequence=0
tempaa=0
nlaa=0

#If the file is in .gz format, we just have to use zgrep instead of grep

sequence=$(grep -c ">" NC_000913.faa) 

tempaa=$(grep -v ">" NC_000913.faa | wc -m)

nlaa=$(grep -v ">" NC_000913.faa | wc -l)

let avg=$((($tempaa-$nlaa)/$sequence))

printf 'Average length of protein in NC_000913 is %s\n\n' "$avg"






