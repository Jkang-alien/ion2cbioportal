#' make translocation data
#'
#' @param tsv_file path/to/tsv/file
#'
#' @return tidy fusion data.frame
#' @import dplyr
#' @import tibble
#' @import readr
#' @export
#'
#' @examples
#' \dontrun{
#' tidy_fusion(tsv_file)
#' }

tidy_fusion <- function (tsv_file) {
  data <- read_delim(tsv_file, delim = "\t", comment = "#")
  if (sum(data$rowtype %in% c("Fusion", "RNAExonVariant")) == 0) {
    #stop()
  } else if (sum(data$rowtype %in% c("Fusion", "RNAExonVariant")) > 0) {
    tidy_data <- data %>% filter(rowtype %in% c("Fusion", "RNAExonVariant")) %>% 
      filter(INFO.1.GENE_NAME %in% fusion_df$Gene) %>% select(rowtype, INFO.1.GENE_NAME, ID)
    return(tidy_data)
  } else {
    #stop()
  }
}


#' make translocation data
#'
#' @param gene_name gene name of OCAv3 fusion
#'
#' @return Entres_Gene_Id
#' @import dplyr
#' @import tibble
#' @export
#'
#' @examples
#' \dontrun{
#' find.Entres_Gene_Id("ALK")
#' }
find.Entres_Gene_Id <- function(gene_name){
  entres <- fusion_df %>%
    filter(Gene == gene_name) %>%
    select(Entres_Gene_Id)
    as.numeric(as.character(entres[1,1]))
}



#' make translocation data
#'
#' @param list_tsv_file list of tsv file name
#'
#' @return tibble with fusion data
#' @import dplyr
#' @import tibble
#' @export
#'
#' @examples
#' \dontrun{
#' make.fusion.df(list_tsv_file)
#' }
make.fusion.df <- function (list_tsv_file) {
  df_fusion <- tibble()
  sample_ID <- stringr::str_extract(list_tsv_file, "M[0-9]{2}-[0-9]{1,8}")
  for (i in 1:length(list_tsv_file)) {
    
    if (is.null(tidy_fusion(list_tsv_file[i]))) {
      df_fusion <- df_fusion
    } else {
      data <- tidy_fusion(list_tsv_file[i])
      df_temp <- tibble(Hugo_Symbol = data$INFO.1.GENE_NAME, 
                        Entrez_Gene_Id = purrr::map_dbl(data$INFO.1.GENE_NAME, 
                                                        find.Entres_Gene_Id),
                        Center = rep("cmc", dim(data)[1]), 
                        Tumor_Sample_Barcode = sample_ID[i],
                        Fusion = data$ID, 
                        DNA_support = rep("no", dim(data)[1]),
                        RNA_support = rep("yes", 
                                          dim(data)[1]), Method = rep("OCAv3", dim(data)[1]), 
                        Frame = rep("in-frame", dim(data)[1]))
      df_fusion <- df_fusion %>% bind_rows(df_temp)
    }
  }
  return(df_fusion)
}



#' make translocation data
#'
#' @param fusion_df tibble with fusion data
#' @param output_file path/to/output/file
#' @return fusion data.file
#' @import dplyr
#' @import tibble
#' @export
#'
#' @examples
#' \dontrun{
#' make.fusion.data.file(fusion_df, output_file)
#' }

make.fusion.data.file <- function(fusion_df, output_file) {
  write.table(fusion_df, file = output_file, 
            append = FALSE, 
            quote = FALSE, 
            sep = "\t", 
            na = "NA", 
            dec = ".", 
            col.names = TRUE, 
            row.names = FALSE)
}
