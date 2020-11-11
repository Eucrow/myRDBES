# myRDBES

myRDBES is a package with the functions I have created to deal with the RDBES 
exchange files.


## Install
With `devtools` package installed:
```
library(devtools)
install_github("Eucrow/myRDBES")
```

## Functions available
Use `?nameofthefunction` to details.
#### importRDBESFile()
Import RDBES exchange files properly formatted and ready to upload in RDBES
database.

The goal of this function is get the tables
of the hierarchy in a list of dataframes to facilitate some checks
in R prior to upload.

No validation of any kind is carried out in this proccess.

## Datasets available
A dataset of every table of all hierarchies: BV, CE, CL, DE, FM, FO, FT, LE, LO,
OS, SA, SD, SL, SS, TE, VD and VS.

All those datasets contain two variables:

- Field Name
- R Name

The order of variables in the dataset is the same order of the variables in the
table.

This dataset has been obtained by the data model spreadsheet available in
[RDBES gitHub repository](https://api.github.com/repos/ices-tools-dev/RDBES/contents/Documents).
To achieve it, I use the function getFieldNameMapping() from
[MI_RDBES_ExchangeFiles](https://github.com/davidcurrie2001/MI_RDBES_ExchangeFiles)
by [David Currie](https://github.com/davidcurrie2001). The function is included
with minor changes.
