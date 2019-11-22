#' Append cnv data to data.frame cnv_df
#'
#' @param x file name
#'
#' @return cnv data.frame
#' @export
#'
#' @examples
#' 

tsv2table <- function(x) {
  sample_ID <- stringr::str_extract(x, 'M[0-9]{2}-[0-9]{1,8}')
  #if (dim(try(read.delim(x)))[1] ==4){
  #  cnv <- cnv
  #} else {
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

#' merge CNV from tsv files
#'
#' @param f_list character vector of tsv file name use list.files
#'
#' @return cnv table with Entres_Gene_Id
#' @export
#'
#' @examples
#' 
#' 


merge_cnv <- function(f_list){
  m_id <- stringr::str_extract(f_list, 'M[0-9]{2}-[0-9]{1,8}')
  cnv_table <- as.numeric(entrez_id)
  for (i in 1:length(f_list)) {
    cnv_table <- cbind(cnv_table, tsv2table(f_list[i]))
  }
  colnames(cnv_table) <- c('Entrez_Gene_Id', m_id)
  return(cnv_table)
}


#' transform cnv table to discrete form 0, 2
#'
#' @param cnv_table matrix table of cnv
#'
#' @return discrete cnv table
#' @export
#'
#' @examples
#'  


discretize_cnv <- function(cnv_table) {
  cnv_table[is.na(cnv_table)] <- 0
  cnv_table[cnv_table>=2] <- 2
  cnv_table[,1] <- as.numeric(entrez_id)
  return(cnv_table)
}