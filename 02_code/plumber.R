#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)
library(tidyverse)
library(digest)

# define custom function
digest_group_hash <- function(df, grp_num){
  df2 <- df[grp_num, ] 
  a <- df2[][[1]] %>% as.character() %>% digest(algo="sha1", serialize=F)
  b <- df2[][[2]] %>% as.character() %>% digest(algo="sha1", serialize=F)
  c <- df2[][[3]] %>% as.character() %>% digest(algo="sha1", serialize=F)
  d <- df2[][[4]] %>% as.character() %>% digest(algo="sha1", serialize=F)
  res <- c(a, b, c, d) %>% as.character() %>% digest(algo="sha1", serialize=F)
  return(res)
}
#* @apiTitle Configuration publisher API

#* Provide correct configuration automatically
#* @param part_num Part Location in the Group
#* @param grp_num Group Number
#* @get /config
function(part_num, grp_num) {
  # read the specification
  df1 <- read_csv("/01_data/master_spec.csv")
  # extract the needed element
  #df1[[1]][[1]]
  #part_num <- "3" #number
  #part_num <- "error" #chr
  #TDL write error management
  part_num <- as.numeric(part_num)
  grp_num <- as.numeric(grp_num)
  df1[[grp_num]][[part_num]]
}

#* Provide correct configuration hash for parts
#* @param part_num Part Number
#* @param grp_num Group Number
#* @get /hash_part
function(part_num, grp_num) {
  # read the specification
  df1 <- read_csv("/01_data/master_spec.csv")
  # extract the needed element
  #df1[[1]][[1]]
  #grp_num <- 1
  #TDL write error management
  part_num <- as.numeric(part_num)
  grp_num <- as.numeric(grp_num)
  df1[[grp_num]][[part_num]] %>% as.character() %>% digest(algo="sha1", serialize=F)
}

#* Provide correct configuration hash
#* @param grp_num Group Number
#* @get /hash_group
function(grp_num) {
  # read the specification
  df1 <- read_csv("/01_data/master_spec.csv")
  # extract the needed element
  #df1[[1]][[1]]
  #grp_num <- 1
  #TDL write error management
  grp_num <- as.numeric(grp_num)
  digest_group_hash(df1, grp_num)
}

#* Provide correct configuration hash for the unit
#* @get /hash_unit
function() {
  # read the specification
  df1 <- read_csv("/01_data/master_spec.csv")
  # extract the needed element
  #df1[[1]][[1]]
  #grp_num <- 1
  
  hash_gr1 <- digest_group_hash(df1, 1)
  hash_gr2 <- digest_group_hash(df1, 2)
  hash_gr3 <- digest_group_hash(df1, 3)
  
  c(hash_gr1, hash_gr2, hash_gr3) %>% as.character() %>% digest(algo="sha1", serialize=F)
}