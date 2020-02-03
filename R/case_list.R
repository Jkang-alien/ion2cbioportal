#' Make case list files
#'
#' @param x path to maf directory 
#'
#' @return case list files (case_list_sequenced, cnvseq, cna) in study-dir/case_lists directory
#' @export
#'
#' @examples
#' \dontrun{
#' make_case_list("~/cbioportal_data/maf")
#' }

make_case_list <- function (x) {
  # Create case_list files in case_lists directory
  dir.create("/home/molpath/cbioportal_data/temp/case_lists")
  file.create("/home/molpath/cbioportal_data/temp/case_lists/case_list_cna")
  file.create("/home/molpath/cbioportal_data/temp/case_lists/case_list_cnvseq")
  file.create("/home/molpath/cbioportal_data/temp/case_lists/case_list_sequenced")
  
  # Write on case list files

  file_path_list <- list.files(x)
  fileConn<-file("/home/molpath/cbioportal_data/temp/case_lists/case_list_cna")
  writeLines(c("cancer_study_identifier: cmc_oca",
              "stable_id: cmc_oca_cna",
              "case_list_name: cmc_oca_cna",
              "case_list_description: cmc_oca_cna",
              paste("case_list_ids: ",
                    paste(stringr::str_extract(list.files(x),
                                               'M[0-9]{2}-[0-9]{1,8}'),
                          collapse="\t"),
                    sep = " ",
                    collapse="")),
             fileConn)
  
  close(fileConn)
  
  fileConn<-file("/home/molpath/cbioportal_data/temp/case_lists/case_list_cnvseq")
  writeLines(c("cancer_study_identifier: cmc_oca",
               "stable_id: cmc_oca_cnvseq",
               "case_list_name: cmc_oca_cnvseq",
               "case_list_description: cmc_oca_cnvseq",
               paste("case_list_ids: ",
                     paste(stringr::str_extract(list.files(x),
                           'M[0-9]{2}-[0-9]{1,8}'),
                           collapse="\t"),
                     sep = " ",
                     collapse="")),
             fileConn)
  
  close(fileConn)
  
  fileConn<-file("/home/molpath/cbioportal_data/temp/case_lists/case_list_sequenced")
  writeLines(c("cancer_study_identifier: cmc_oca",
               "stable_id: cmc_oca_sequenced",
               "case_list_name: cmc_oca_sequenced",
               "case_list_description: cmc_oca_sequenced",
               paste("case_list_ids: ",
                     paste(stringr::str_extract(list.files(x),
                                                'M[0-9]{2}-[0-9]{1,8}'),
                           collapse="\t"),
                     sep = " ",
                     collapse="")),
             fileConn)
  
  close(fileConn)
}