

#' downlad vcf file
#' @examples
#' \dontrun{
#' downloadvcf()
#' }
#'
#' @export
#'
downloadvcf <- function (){
system2(command = "bash", c("-i", "~/downloadIonFiles.sh"))
fileListRaw <- list.files("~/ngsData/OCAplus/raw", recursive = TRUE, full.names = TRUE)
load("~/ngsData/OCAplus/archive/RData/fileList.RData")
fileListNew <- fileListRaw[!(fileListRaw %in% fileListOld)]
vcfNew <- fileListNew[grep("vcf$", fileListNew)]
file.copy(from = vcfNew, to = "~/ngsData/OCAplus/new/vcf", recursive = FALSE)
fileListOld <- fileListRaw
save(file = paste0("~/ngsData/OCAplus/archive/RData/fileList.RData"), fileListOld)
}

