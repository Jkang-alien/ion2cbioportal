
#' merge maf from vcf file
#'
#' @param input_directory character of directory of vcf files
#' 
#' @return merged maf file
#' 
#' @export
#'
#' @examples
#' 
#' \dontrun{
#' all_maf("./maf")}

all_maf <- function(input_directory){
  maf_all <- maftools::merge_mafs(list.files(input_directory, full.names = TRUE))
  maftools::write.mafSummary(maf_all, "all")
  file.remove(c("all_geneSummary.txt", "all_sampleSummary.txt", "all_summary.txt"))
  file.show("all_maftools.maf")
  filesstrings::file.move("./all_maftools.maf", "./example_data", overwrite = TRUE)
}
