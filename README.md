## Natural language processing

This small R script contains the code that was used to produce the plots and results presented in the report.pdf file. To run the code, you should install the required R packages (quanteda, spacyR and utf8). Afterwards, running the following commands creates the necessary spacy environment : 

```R
library(spacyr)
spacy_install(prompt=FALSE)
spacy_download_langmodel('es')
```
