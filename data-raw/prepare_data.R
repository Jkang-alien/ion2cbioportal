###########################################################
######## Gene symbol to Enterez ID of cnv genes in OCA ####
###########################################################

library(org.Hs.eg.db)
e2s = toTable(org.Hs.egSYMBOL)
cnv_genes <- "AKT1 AKT2 AKT3 ALK AXL AR BRAF CCND1 CCND2 CCND3 CCNE1 CDK2 CDK4 CDK6 EGFR ERBB2 ESR1 FGF19 FGF3 FGFR1 FGFR2 FGFR3 FGFR4 FLT3 IGF1R KIT KRAS MDM2 MDM4 MET MYC MYCL MYCN NTRK1 NTRK2 NTRK3 PDGFRA PDGFRB PIK3CB PIK3CA PPARG RICTOR TERT"
gene_list <- unlist(strsplit(cnv_genes, " "))

entrez_id <- c()
for (i in gene_list) {
  a <- e2s$gene_id[e2s$symbol == i]
  entrez_id <- append (entrez_id, a)
}

cnv_df <- data.frame(Entres_Gene_Id = entrez_id)
cnv <- c(rep(NA, length(gene_list)))

fusion_genes <- "AKT2
ALK
AR
AXL
BRCA1
BRCA2
BRAF
CDKN2A
EGFR
ERBB2
ERBB4
ERG
ESR1
ETV1
ETV4
ETV5
FGFR1
FGFR2
FGFR3
FGR
FLT3
JAK2
KRAS
MDM4
MET
MYB
MYBL1
NF1
NOTCH1
NOTCH4
NRG1
NTRK1
NTRK2
NTRK3
NUTM1
PDGFRA
PDGFRB
PIK3CA
PRKACA
PRKACB
PTEN
PPARG
RAD51B
RAF1
RB1
RELA
RET
ROS1
RSPO2
RSPO3
TERT"

fusion_gene_list <- unlist(strsplit(fusion_genes, "\n"))

fusion_entrez_id <- c()
for (i in fusion_gene_list) {
  a <- e2s$gene_id[e2s$symbol == i]
  fusion_entrez_id <- append (fusion_entrez_id, a)
}

fusion_df <- data.frame(Entres_Gene_Id = fusion_entrez_id, Gene = fusion_gene_list)


usethis::use_data(cnv, entrez_id, gene_list, cnv_df, fusion_entrez_id, fusion_df,
                  internal = TRUE, overwrite =TRUE)
