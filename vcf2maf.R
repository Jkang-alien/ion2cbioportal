vcf_list <- list.files("/home/molpath/cbioportal_data/output/vcf/", full.names = TRUE)
m_id <- stringr::str_extract(vcf_list, 'M[0-9]{2}-[0-9]{1,8}')
program_vcf2maf <- "/home/molpath/mskcc-vcf2maf-decbf60/vcf2maf.pl"
arg1 <- paste("--input-vcf", vcf_list)
arg2 <- paste0("--output-maf /home/molpath/cbioportal_data/maf/", m_id, ".maf")
arg3 <- paste("--tumor-id", m_id)

vcf2maf_script <- paste(program_vcf2maf, arg1, arg2, arg3)
old_path <- Sys.getenv("PATH")
Sys.setenv(PATH = paste(old_path, "/home/molpath/samtools-1.8/", sep = ":"))
system(vcf2maf_script[1]) 