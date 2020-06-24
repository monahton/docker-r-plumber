# Dockerfile to run R script

FROM vladdsm/docker-r-h2o

LABEL maintainer='vladimir.zhbanko@gmail.com'

## create directories
RUN mkdir -p /01_data
RUN mkdir -p /02_code
RUN mkdir -p /03_output

## add specific files
ADD /01_data/master_spec.csv /01_data/master_spec.csv

## copy working script
COPY /02_code/script2run.R /02_code/script2run.R
COPY /02_code/plumber.R /02_code/plumber.R

EXPOSE 8787

## run the script on running container
#CMD bash #use this command to check if the files are copied

ENTRYPOINT ["Rscript", "/02_code/script2run.R"]

#CMD Rscript /02_code/script2run.R

## command to run this container
#docker run -d --rm --network=my-net --net-alias=API -p 8777:8787 --name API vladdsm/docker-r-plumber