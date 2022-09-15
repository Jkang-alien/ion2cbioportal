## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, eval = FALSE)

## ----extract_ion2cbio---------------------------------------------------------
#  extract_ion2cbio("/home/molpath/cbioportal_data/zip", "/home/molpath/cbioportal_data/output")

## ----vcf2maf------------------------------------------------------------------
#  vcf_list <- list.files("/home/molpath/cbioportal_data/output/vcf/", full.names = TRUE)
#  m_id <- stringr::str_extract(vcf_list, 'M[0-9]{2}-[0-9]{1,8}')
#  program_vcf2maf <- "/home/molpath/mskcc-vcf2maf-decbf60/vcf2maf.pl"
#  arg1 <- paste("--input-vcf", vcf_list)
#  arg2 <- paste0("--output-maf /home/molpath/cbioportal_data/maf/", m_id, ".maf")
#  arg3 <- paste("--tumor-id", m_id)
#  
#  vcf2maf_script <- paste(program_vcf2maf, arg1, arg2, arg3)
#  old_path <- Sys.getenv("PATH")
#  Sys.setenv(PATH = paste(old_path, "/home/molpath/samtools-1.8/", sep = ":"))
#  system(vcf2maf_script[1])

## ----merge maf----------------------------------------------------------------
#  all_maf("./maf", "/output/directory")

## ----merge cnv----------------------------------------------------------------
#  table_cnv <- merge_cnv(f_list)
#  discrete_cnv <- discretize_cnv(table_cnv)
#  write.table(table_cnv, './example_data/data_log2_CNA.txt', append = FALSE, quote = FALSE, sep = "\t", na = "NA", dec = ".", col.names = TRUE, row.names = FALSE)
#  write.table(discrete_table, './example_data/data_CNA.txt', append = FALSE, quote = FALSE, sep = "\t", na = "NA", dec = ".", col.names = TRUE, row.names = FALSE)

## -----------------------------------------------------------------------------
#  make_case_list("~/cbioportal_data/maf")

## -----------------------------------------------------------------------------
#  append_patient(new_patient_file, old_patient_file)
#  append_sample(new_sample_file, old_sampe_file)

## -----------------------------------------------------------------------------
#  append_all_maf(new_maf_file, old_maf_file)

## -----------------------------------------------------------------------------
#  append_discrete_cnv(new_discrete_cnv_table, old_discrete_cnv_file)

## -----------------------------------------------------------------------------
#  append_list(new_list_directory, old_list_directory)

