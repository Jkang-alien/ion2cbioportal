
#' merge maf
#'
#' @param input_directory character of directory of maf files
#' 
#' @param output_directory character of directory of merged maf files
#' 
#' @return merged maf file
#' 
#' @export
#'
#' @examples
#' 
#' \dontrun{
#' all_maf("./maf", "/output/directory/")}

all_maf <- function(input_directory, output_directory){
  maf_all <- maftools::merge_mafs(list.files(input_directory, full.names = TRUE))
  maftools::write.mafSummary(maf_all, "all")
  file.remove(c("all_geneSummary.txt", "all_sampleSummary.txt", "all_summary.txt"))
  file.show("all_maftools.maf")
  filesstrings::file.move("./all_maftools.maf", output_directory, overwrite = TRUE)
}
