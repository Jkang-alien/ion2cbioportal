#' copy vcf to rename vcf into output directory
#'
#' @param inputVcfDirectory string of path to input directory
#' @param outputVcfDirectory string of path to output directory
#' @return copy vcf to rename vcf into output directory
#' @import dplyr
#' @import purrr
#' @import stringr
#' @import ggplot2
#'  
#' @export
#'
#' @examples
#' \dontrun{
#' copyRenameVcf(vcf, "vcfRename")
#' }
#' 
#' 
copyRenameVcf <- function(inputVcfDirectory, outputVcfDirectory) {
  if (!dir.exists(outputVcfDirectory)){
    dir.create(outputVcfDirectory)
  }
  newFileListFull <- renamefileFull(inputVcfDirectory, outputVcfDirectory)
  inputFileList <- list.files(inputVcfDirectory, full.names = TRUE)
  file.copy(inputFileList, newFileListFull, overwrite = TRUE)
}

renameFile <- function(filename){
  filenameSplits <- filename|>str_split("_v1")|>unlist()
  id <- filenameSplits[1]
  idSplits <- str_split(id, "-") |> unlist()
  
  if(length(idSplits) != 2)
    stop("please check id format (M**-numbers)")
  if(str_length(idSplits[2]) > 6) 
    stop("please check id format. The id number digit should be less than 6")
  
  lengthZero <- 6 - str_length(idSplits[2])
  
  zeros <- str_dup("0", lengthZero)
  newname <- str_c(idSplits[1], "-", zeros, idSplits[2], ".vcf")
  
  if(!grepl("M[0-9]{2}-[0-9]{6}\\.vcf", newname))
    stop("Check file name")
     
  return(newname)
}


renamefileFull <- function(inputVcfDirectory, outputVcfDirectory){
  fileList <- list.files(inputVcfDirectory)
  newFileList <- purrr::modify(fileList, renameFile)
  newFileListFull <- purrr::modify(newFileList, ~stringr::str_glue(outputVcfDirectory, "/", .))
  return(newFileListFull)
}




