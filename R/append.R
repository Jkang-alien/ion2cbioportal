#' Append all_maf file
#' @param pathTodirectory path to directory of new maf
#' @param new_maf_file file path to new maf file 
#' @param old_maf_file file path to old maf file
#' @return make appended all_maf file in temp subdirectory of the old maf directory
#' @export
#' @examples
#' \dontrun{
#' append_all_maf(pathTodirectory, new_maf_file, old_maf_file)
#' }

append_all_maf <- function(pathTodirectory, new_maf_file, old_maf_file){
  
  if (!dir.exists(paste0(pathTodirectory, "/temp"))){
    dir.create(paste0(pathTodirectory, "/temp"))
  }
  
  file.copy(old_maf_file, 
            paste0(pathTodirectory, "/temp/all_maf.maf"),
            overwrite = TRUE)
  
  new_maf <- readLines(new_maf_file,
                       skipNul = TRUE)
  write(new_maf[-1],
        file=paste0(pathTodirectory, "/temp/all_maf.maf"),
        append=TRUE)
}

#' Append patient data file
#'
#' @param new_patient_file file path to new patient data file
#' 
#' @param old_patient_file file path to old patient data file
#' 
#' @return appended patient data file overriding the original data file
#'
#' @export
#'
#' @examples
#' \dontrun{
#' append_patient(new_patient_file, old_patient_file)
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
#' @param pathTodirectory directory path to data file
#' @param new_sample_file file path to new sample data file 
#' @param old_sample_file file path to old sample data file 
#' @return appended sample data file overriding the original data file
#' @export
#' @examples
#' \dontrun{
#' append_sample(pathTodirectory, new_sample_file, old_sampe_file)
#' }

append_sample <- function(pathTodirectory, new_sample_file, old_sample_file){
  file.copy(old_sample_file, 
            paste0(pathTodirectory, "/temp/sample_data.txt"),
            overwrite = TRUE)
  con <- file(new_sample_file)
  new_sample <- readLines(con,skipNul = TRUE)
  close(con)
  write(new_sample[-1], 
        file=paste0(pathTodirectory, "/temp/sample_data.txt"), 
        append=TRUE)
}

#' Append case list file
#'
#' @param new_list_directory file path to new case list directory
#' 
#' @param old_list_directory file path to old case list directory
#' 
#' @return appended case list data files overriding the original data files
#'
#' @export
#'
#' @examples
#' \dontrun{
#' append_list(new_list_directory, old_list_directory)
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



#' Append discrete cnv file
#'
#' @param new_discrete_cnv_table new discrete cnv data table generated by \code{\link{discretize_cnv}}
#' 
#' @param old_discrete_cnv_file file path to old discrete cnv file
#' 
#' @return appended case list data files overriding the original data files
#'
#' @export
#'
#' @examples
#' \dontrun{
#' append_discrete_cnv(new_discrete_cnv_table, old_discrete_cnv_file)
#' }
#' 
append_discrete_cnv <- function(new_discrete_cnv_table, old_discrete_cnv_file){
old_table_cnv <- readr::read_delim(old_discrete_cnv_file, delim = "\t" )
appended_cnv <- cbind(old_table_cnv, new_discrete_cnv_table[,-1])
write.table(appended_cnv, file = old_discrete_cnv_file, 
            append = FALSE, 
            quote = FALSE, 
            sep = "\t", 
            na = "NA", 
            dec = ".", 
            col.names = TRUE, 
            row.names = FALSE)
}

#' Append fusion file
#'
#' @param new_fusion_df new fusion data table generated by \code{\link{make.fusion.df}}
#' 
#' @param old_fusion_file file path to old fusion file
#' 
#' 
#' @return appended fusion data files overriding the original data files
#' @import dplyr
#' @import readr
#' @export
#'
#' @examples
#' \dontrun{
#' append_fusion(new_fusion_df, old_fusion_file)
#' }
#' 
append_fusion <- function(new_fusion_df, old_fusion_file) {
  old <- read_delim(old_fusion_file, delim = "\t")
  appended_df <- old %>%
    bind_rows(new_fusion_df)
  make.fusion.data.file(appended_df, old_fusion_file)
}
