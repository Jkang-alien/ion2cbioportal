
#devtools::use_data(cnv, entrez_id, gene_list, internal = TRUE, overwrite =TRUE)


#' Append cnv data to data.frame cnv_df
#'
#' @param x file name
#'
#' @return cnv data.frame
#' @export
#'
#' @examples
#' 
#' 

cnv_table <- function(x) {
  sample_ID <- unlist(strsplit(x, '_'))[1]
  if (dim(try(read.delim(x)))[1] ==4){
    cnv <- cnv
  } else {
    data <- read.delim(x, comment.char = "#")
    cn <- data$FORMAT.1.CN[data$rowtype=='CNV']
    gene_id <- as.character(data$ID[data$rowtype=='CNV'])
      if (length(cn) == 0) {
        cnv <- cnv
        } else {
      for (i in 1:length(cn)){
      cnv[gene_list==gene_id[i]] <- round(log2(cn[i]), digits = 2)
      }
  }
  }
   cnv <- cbind(cnv)
   colnames(cnv) <- sample_ID
   return(cnv)
  }

#' append CNV from file name vector
#'
#' @param x file name vector
#'
#' @return cnv table with Entres_Gene_Id
#' @export
#'
#' @examples
#'
append.cnv <- function(x) {
  table <- as.numeric(entrez_id)
  for (j in x) {
    table <- cbind(table, cnv_table(j))
  }
  colnames(table)[1] <- 'Entrez_Gene_Id'
  return(table)
}
