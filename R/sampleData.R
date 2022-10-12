#' Make sample data files
#'
#' @param pathInput path to maf directory 
#' @param pathOutput path to output 
#' @return sample data files 
#' @import readr
#' @export
#'
#' @examples
#' \dontrun{
#' make_sample_data_file("input/directory", "output/directory" )
#' }

make_sample_data_file <- function (pathInput, pathOutput) {
  
  # make sample data tibble
  
  SAMPLE_ID <- stringr::str_extract(list.files(pathInput), '[A-Z]{1,2}[0-9]{2}-[0-9]{6}')
  
  sampleTibble <- tibble(SAMPLE_ID, PATIENT_ID = SAMPLE_ID)
  
  # Write on sample data files
  if(!dir.exists(paste0(pathOutput, "/temp/"))){
    (dir.create(paste0(pathOutput, "/temp/")))
     }
                 
  write_tsv(sampleTibble, file = paste0(pathOutput, "/temp/sample.txt"))
}