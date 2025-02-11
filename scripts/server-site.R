options(browser = "/usr/bin/firefox")

library(reticulate)
library(knitr)
library(rmarkdown)

reticulate::use_python("/usr/bin/python3", required=TRUE)

blogdown::build_site(local=TRUE, run_hugo=TRUE, build_rmd=TRUE)
blogdown::serve_site(port = 7989)
