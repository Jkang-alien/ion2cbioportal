
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
#'

all_maf <- function(input_directory){
  maf_all <- maftools::merge_mafs(list.files(input_directory, full.names = TRUE))
  maftools::write.mafSummary(maf_all, "all")
}