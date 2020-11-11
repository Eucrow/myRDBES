# Create mapping tables with columna names of all the RDBES exchange format.

variable_names <- getFieldNameMapping(fileLocation = paste0(getwd(), "/data-raw/"))

variable_names <- split(variable_names, variable_names$TableName)

variable_names <- lapply(variable_names, function(x){
  # remove TableName variable
  x <- x[, c('Field Name', 'R Name')]
  colnames(x) <- c('FieldName', 'RName')
  return(x)
})

for (i in names(variable_names)) {
  assign(i, variable_names[[i]])
}

# TODO: as use_data requires the objects to save in package without quotes,
# makes difficult to include it in a apply, so:
usethis::use_data(BV,CE,CL,DE,FM,FO,FT,LE,LO,OS,SA,SD,SL,SS,TE,VD,VS, overwrite = TRUE)
usethis::use_data_raw()

