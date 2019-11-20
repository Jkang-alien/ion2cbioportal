clinical <- read.delim('~/cbioportal_data_file/NGS_ID.txt', comment.char = '#')
SEX <- c(unlist(strsplit(as.character(clinical$AGE.SEX), '/'))[seq(1, 408, 2)],
  NA, unlist(strsplit(as.character(clinical$AGE.SEX), '/'))[seq(410, 616, 2)])
AGE <- as.numeric( c(unlist(strsplit(as.character(clinical$AGE.SEX), '/'))[seq(2, 408, 2)],
         NA, unlist(strsplit(as.character(clinical$AGE.SEX), '/'))[seq(411, 618, 2)]))
clinical$AGE <- AGE
clinical$SEX <- SEX

summary_NGS <- read.csv('~/Downloads/NGS_summary.csv')
colnames(summary_NGS) <- c('SAMPLE_ID', 'T_id', 'SEX', 'TUMOR_SITE', 'TYPE_OF_CANCER', 'CELLULARITY')
data_clinical <- merge (clinical, summary_NGS[,c(1,4:6)], by = 'SAMPLE_ID', all.x = TRUE, all.y = FALSE)
data_clinical <- data_clinical[duplicated(data_clinical$SAMPLE_ID) == FALSE, ]
colnames(data_clinical)
data_sample <- data_clinical[,c(1,2,3,8:10)]
data_patient <- data_clinical[duplicated(data_clinical$PATIENT_ID) == FALSE, c(3, 5:7)]

write.table(data_sample, '~/cbioportal_data_file/data_sample.txt', 
            append = FALSE, quote = FALSE, sep = "\t",
            na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE)
write.table(data_patient, '~/cbioportal_data_file/data_patient.txt', 
            append = FALSE, quote = FALSE, sep = "\t",
            na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE)
summary(data_sample$TYPE_OF_CANCER)
