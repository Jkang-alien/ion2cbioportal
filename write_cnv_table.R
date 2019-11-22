

write.table(table, 'data_log2_CNA.txt', append = FALSE, quote = FALSE,
            sep = "\t", na = "NA", dec = ".", col.names = TRUE, row.names = FALSE)

write.table(discrete_table, '/home/molpath/cbioportal_data_file/data_CNA.txt', append = FALSE, quote = FALSE,
            sep = "\t", na = "NA", dec = ".", col.names = TRUE, row.names = FALSE)