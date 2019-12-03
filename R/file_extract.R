

#' extract vcf filtered and tsv filtered files from ion torrent zip files
#'
#' @param input_directory string of path to input directory
#' @param output_directory string of path to output directory
#' @return extract vcf and tsv files to vcf and tsv directory
#' @export
#'
#' @examples
#' \dontrun{
#' extract_ion2cbio("/home/molpath/cbioportal_data/zip", "/home/molpath/cbioportal_data/output")
#' }
#' 

extract_ion2cbio <- function(input_directory, output_directory){
  
  if (file.exists(output_directory)){
    
  } else {
    dir.create(file.path(output_directory))
  }
  
  list_zip_files <- list.files(input_directory, full.names=TRUE)

  for (i in 1:length(list_zip_files)) {
    output_dir <- paste0(output_directory, "/", i)
    unzip(list_zip_files[i], exdir = output_dir, unzip = "unzip")
  }
  
  dir.create(file.path(paste0(output_directory, "/vcf")))
  dir.create(file.path(paste0(output_directory, "/tsv")))
  
  for (i in 1:length(list_zip_files)) {
    list_files <- list.files(paste0(output_directory, "/", i, "/Variants/"),
               recursive = TRUE, 
               full.names=TRUE)
    from <- list_files[grep("Filtered.*vcf$", list_files)]
    molecular_number <- stringr::str_extract(from, 'M[0-9]{2}-[0-9]{1,8}')
    to <- paste0(output_directory, "/vcf/", molecular_number, i, ".vcf")
    
    file.copy(from, to)
  }


  for (i in 1:length(list_zip_files)) {
    list_files <- list.files(paste0(output_directory, "/", i, "/Variants/"),
                             recursive = TRUE, 
                             full.names=TRUE)
    from <- list_files[grep("oncomine.tsv$", list_files)]
    molecular_number <- stringr::str_extract(from, 'M[0-9]{2}-[0-9]{1,8}')
    to <- paste0(output_directory, "/tsv/", molecular_number, i, ".tsv")
    file.copy(from, to)
  }
}