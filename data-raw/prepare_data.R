###########################################################
######## Gene symbol to Enterez ID of cnv genes in OCA ####
###########################################################

library(org.Hs.eg.db)
e2s = toTable(org.Hs.egSYMBOL)
oca <- read.csv('oca.csv')
gene_list <- as.character(oca$GENE[oca$CNV == 'CNV'])

entrez_id <- c()
for (i in gene_list) {
  a <- e2s$gene_id[e2s$symbol == i]
  entrez_id <- append (entrez_id, a)
}

cnv_df <- data.frame(Entres_Gene_Id = entrez_id)
cnv <- c(rep(NA, length(gene_list)))

devtools::use_data(cnv, entrez_id, gene_list, cnv_df, internal = TRUE, overwrite =TRUE)
