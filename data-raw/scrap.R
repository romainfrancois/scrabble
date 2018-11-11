library(rvest)
library(tidyverse)
library(glue)

fonction <- function(nb, verbose = TRUE){
  url <- if(nb == 1){
    "https://www.listesdemots.net/touslesmotstaille.htm"
  } else {
    glue("https://www.listesdemots.net/touslesmotstaillepage{nb}.htm")
  }
  if(verbose) cat("\r", nb)
  read_html(url) %>%
    html_node(".mot") %>%
    html_text() %>%
    strsplit(" ") %>%
    flatten_chr()
}

col <- map(1:800, fonction) %>%
  flatten_chr()

mots_scrabble <- tibble(mots = col, n = nchar(col)) %>%
  filter(n <= 15)
