#' update all_maf file
#' @examples
#' \dontrun{
#' updataMafAll()
#' }
#'
#' @export
#'
updataMafAll <- function (){
  copyRenameVcf("~/ngsData/OCAplus/new/vcf", '~/ngsData/OCAplus/new/vcf_rename')
  system2(command = "bash", c("-i", "~/vcf2mafGRCh38oca.sh"))
  all_maf("~/ngsData/OCAplus/new/maf", "~/ngsData/OCAplus/new/mafAll")
 
  new_maf <- readLines("~/ngsData/OCAplus/new/mafAll/all_maftools.maf",
                       skipNul = TRUE)
  write(new_maf[-1],
        file="~/ngsData/OCAplus/current/all_maftools.maf",
        append=TRUE)
}


