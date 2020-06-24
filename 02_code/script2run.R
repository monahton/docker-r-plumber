
# deploy the RESTful API
library(plumber)
r <- plumb("/02_code/plumber.R")
r$run(port=8797, host="0.0.0.0")
