#' update cmcNgsShiny maf
#' @import pins
#' @import dplyr
#' @import maftools
#' @examples
#' \dontrun{
#' updateShinyMaf()
#' }
#' @export
#' 


updataShinyMaf <- function (){
  downloadvcf()
  updataMafAll()
  archive()
  maf <- maftools::read.maf("~/ngsData/OCAplus/current/all_maftools.maf")
  mafdata <- maf@data
  data <- mafdata|>
    select(Tumor_Sample_Barcode,
           Hugo_Symbol,
           starts_with("HGVS"),
           Variant_Type)
  board <- board_folder("~/board")
  board |> pin_write(data)
}
