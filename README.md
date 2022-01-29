# Intelligent Systems

Code produced in the context of the course "Intelligent Systems" given at the [UNIVERSIDAD POLITÉCNICA DE MADRID](https://www.upm.es/) during year 2021-2022. 

## Natural language processing

This small R script contains the code that was used to produce the plots and results presented in the report.pdf file. To run the code, you should install the required R packages (quanteda, spacyR and utf8). If you don't have it already you may need to install [Anaconda](https://www.anaconda.com/products/individual#windows). Afterwards, running the following commands creates the necessary spacy environment : 

```R
library(spacyr)
spacy_install(prompt=FALSE)
spacy_download_langmodel('es')
```
