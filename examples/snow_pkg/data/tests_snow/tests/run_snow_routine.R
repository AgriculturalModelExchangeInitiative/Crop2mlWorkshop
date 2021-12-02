# sourcing functions & lib_path
source("snow_routine.R")
reload_lib(lib_path)

# data path
dpath <- "./data"
# setting files paths
wpath <- file.path(dpath, "climate_before.csv")
ppath <- file.path(dpath, "snow_model3_param.txt")
ipath <- file.path(dpath, "snow_model_init.txt")

# loading wheather data
dw <- read.csv2(wpath, sep=";", header = T, stringsAsFactors = F)
jul <- dw$jul
tmin <- dw$ttmin
tmax <- dw$ttmax
precip <- dw$ttrr

days <- 1:length(jul)
#days <- 1:365

# loading parameters values
p <- readLines(ppath)
dp <- data.frame(par = p[seq(1,22,2)], value = as.numeric(p[seq(2,22,2)]),
                 stringsAsFactors = F)

for (i in 1:dim(dp)[1]) {
  assign(dp$par[i],dp$value[i])
}

# init values, not got from file
Sdepth_in = 0
Sdry_in = 0
Swet_in = 0
ps_in = 0
in_debug = F

# running the snow models
r <- snow_routine(tsmax, trmax, DKmax,
                  Kmin, Tmf, SWrf, Pns, E, prof, tminseuil,
                  tmaxseuil, tmax[days], tmin[days], jul[days], 
                  precip[days], Sdry_in, Swet_in, ps_in, 
                  Sdepth_in, in_debug)



