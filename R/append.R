#' Append all_maf file
#'
#' @param new_maf_file file path to new patient data file
#' 
#' @param old_maf_file file path to old patient data file
#' 
#' @return appended all_maf file in /home/molpath/cbioportal_data/study-dir/
#'
#' @export
#'
#' @examples
#' \dontrun{
#' append_all_maf()
#' }

append_all_maf <- function(new_maf_file, old_maf_file){
  new_maf <- readLines(new_maf_file,
                       skipNul = TRUE)
  write(new_maf[-1],
        file=old_maf_file,
        append=TRUE)
}

#' Append patient data file
#'
#' @param new_patient_file file path to new patient data file
#' 
#' @param old_patient_file file path to old patient data file
#' 
#' @return appended patient data file in /home/molpath/cbioportal_data/study-dir/
#'
#' @export
#'
#' @examples
#' \dontrun{
#' append_all_maf(new_patient_file, old_patient_file)
#' }

append_patient <- function(new_patient_file, old_patient_file){
  con <- file(new_patient_file)
  new_patient <- readLines(con,skipNul = TRUE)
  close(con)
  write(new_patient[-(1:5)], 
        file=old_patient_file, 
        append=TRUE)
}

#' Append sample data file
#'
#' @param new_sample_file file path to new patient data file
#' 
#' @param old_sample_file file path to old patient data file
#' 
#' @return appended patient data file in /home/molpath/cbioportal_data/study-dir/
#'
#' @export
#'
#' @examples
#' \dontrun{
#' append_all_maf(new_sample_file, old_sampe_file)
#' }

append_sample <- function(new_sample_file, old_sample_file){
  con <- file(new_sample_file)
  new_sample <- readLines(con,skipNul = TRUE)
  close(con)
  write(new_sample[-(1:5)], 
        file=old_sample_file, 
        append=TRUE)
}

#' Append case list file
#'
#' @param new_list_directory file path to new patient data file
#' 
#' @param old_list_directory file path to old patient data file
#' 
#' @return appended patient data file in /home/molpath/cbioportal_data/study-dir/
#'
#' @export
#'
#' @examples
#' \dontrun{
#' append_all_maf(new_sample_file, old_sampe_file)
#' }
append_list <- function(new_list_directory, old_list_directory){
  
    new_files <- list.files(new_list_directory, full.names = TRUE)
    old_files <- list.files(old_list_directory, full.names = TRUE)
    ########### CNA  ###############
  
    # New list
    con <- file(new_files[1])
    case_list_cna <- readLines(con,skipNul = TRUE)
    new_case_list_cna <- paste0("\t", sub("case_list_ids:  ", "", case_list_cna[5]))
    close(con)
    
    # Old list
    con <- file(old_files[1])
    case_list_cna <- readLines(con,skipNul = TRUE)
    old_case_list_cna <- paste0("\t", sub("case_list_ids:  ", "", case_list_cna[5]))
    close(con)
    
    # Append new to old list
    
    
  
    # Write on case list files
    

    fileConn<-file("/home/molpath/cbioportal_data/study-dir/case_lists/case_list_cna")
    writeLines(c("cancer_study_identifier: cmc_oca",
                 "stable_id: cmc_oca_cna",
                 "case_list_name: cmc_oca_cna",
                 "case_list_description: cmc_oca_cna",
                 paste0("case_list_ids: ", old_case_list_cna, new_case_list_cna)),
                 fileConn)
    close(fileConn)

  ########### CNVSEQ  ###############

  # Write on case list files
  
  
  fileConn<-file("/home/molpath/cbioportal_data/study-dir/case_lists/case_list_cnvseq")
  writeLines(c("cancer_study_identifier: cmc_oca",
               "stable_id: cmc_oca_cnvseq",
               "case_list_name: cmc_oca_cnvseq",
               "case_list_description: cmc_oca_cnvseq",
               paste0("case_list_ids: ", old_case_list_cna, new_case_list_cna)),
             fileConn)
  close(fileConn)
  
  ########### sequenced ###############

  # Write on case list files
  
  
  fileConn<-file("/home/molpath/cbioportal_data/study-dir/case_lists/case_list_sequenced")
  writeLines(c("cancer_study_identifier: cmc_oca",
               "stable_id: cmc_oca_sequenced",
               "case_list_name: cmc_oca_sequenced",
               "case_list_description: cmc_oca_sequenced",
               paste0("case_list_ids: ", old_case_list_cna, new_case_list_cna)),
             fileConn)
  close(fileConn)

}
