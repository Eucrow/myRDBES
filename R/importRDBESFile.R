#' Read a RDBES import file and store it as a list with a dataframe by table.
#'
#' Read the data as is, without any kind of validation. The purpouse of this
#' function is facilitate a simple validation by table.
#'
#' @param file vector with the Accidentals filenames.
#' @param path path of the files. The working directory by default.
#' @return Return list of dataframes.
#' @export

importRDBESFile <- function(file, path = getwd()){

  # open connection
  con <- file(paste(path, file, sep="/"))

  # import data
  complete <- readLines(con)
  complete <- as.data.frame(complete)

  # Close connection
  close(con)

  # Split in dataframes by record type
  complete$record_type <- substr(complete$complete, start=1, stop = 2)

  complete <- split(complete, complete$record_type)

  # Split by comma
  complete <- lapply(complete,function(x){
    splitted <- apply(x, 1, function(y){
    # To split by comma a row, previously we have to check if the last
    # character is a comma. If this is the case it means that the last field
    # is empty and strsplit function ignore the last comma because there aren't
    # any character after. So I add a white space
    # TODO: Are there any best way to manage it?
      if(substr(y['complete'], nchar(y['complete']), nchar(y['complete']))==","){
        y['complete'] <- paste0(y['complete'], " ")

      }
      strsplit(y['complete'], ",")
    })
    df <- data.frame(matrix(unlist(splitted), nrow=length(splitted), byrow=T))
  })

  # Add colnames to dataframes
  # Some of the variables of the RDBES format is not in the file to upload to
  # RDBES, like primary or foreing keys. This variables are always in the first
  # positions of the dataframe.
  complete <- lapply(complete, function(x){
    table_name <- unique(x[[1]])
    vn <- eval(as.name(table_name))
    vn <- vn[['RName']]
    colnames(x) <- vn[((length(vn)-ncol(x))+1):length(vn)]
    return(x)
  })

}
