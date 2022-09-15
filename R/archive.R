#' archive and delete file
#' @examples
#' \dontrun{
#' archive()
#' }
#' @export

archive <- function (){
dir.create(paste0("~/ngsData/OCAplus/archive/", Sys.Date()))
file.copy(list.files("~/ngsData/OCAplus/current/", full.names = TRUE),
          paste0("~/ngsData/OCAplus/archive/", Sys.Date()),
          recursive = TRUE,
          overwrite = TRUE)
file.remove(list.files("~/ngsData/OCAplus/new", full.names = TRUE, recursive = TRUE))
}