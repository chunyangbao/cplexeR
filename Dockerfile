FROM index.docker.io/cbao2/cplex:v12.8

COPY . /cplexer
WORKDIR /cplexer

#### Basic image utilities
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common \
     curl libcurl4-gnutls-dev libssl-dev git && \
    apt-get -y clean && \
    apt-get -y autoclean && \
    apt-get -y autoremove

# R
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 && \
    add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu xenial-cran35/" && \
    apt-get update && \
    apt-get install -y --force-yes \
        r-base-dev=3.5.1-1xenial \
        r-base-core=3.5.1-1xenial && \
    apt-get -y clean && \
    apt-get -y autoremove && \
    apt-get  -y autoclean

# R environment
RUN Rscript -e "install.packages('BiocManager', repos='http://cran.us.r-project.org', clean=TRUE)" && \
    Rscript -e "BiocManager::install(ask = FALSE)" && \
    Rscript -e "install.packages('devtools', repos='http://cran.us.r-project.org', clean=TRUE)" && \
    rm -rf /var/lib/apt/lists/*

# Define default command.
CMD ["bash"]
