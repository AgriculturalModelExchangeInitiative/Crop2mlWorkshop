# The lib is loaded only once
lib_path = "./lib/libsnowroutine.so"



load_lib <- function(lib_path, debug = F) {
  if (!is.loaded("test_add")) {
    dyn.load(lib_path)
    if (debug) print(paste0("Loading ",lib_path))
    return(invisible())
  }
  if (debug) print(paste0("Already loaded: ",lib_path))
}

unload_lib <- function(lib_path, debug = F) {
  if (is.loaded("test_add")) {
    if (debug) print(paste0("Unloading ",lib_path))
    dyn.unload(lib_path)
    return(invisible())
  }
  if (debug) print(paste0("Not loaded: ",lib_path))
}

reload_lib <- function(lib_path, debug = F) {
  unload_lib(lib_path, debug)
  load_lib(lib_path, debug)
}

test_add_base <- function(x, y, debug = FALSE) {
  # Base function calling external fortran routine
  
  r = .Fortran( "test_add", x = as.double(x), y = as.double(y),
                z_sum = as.double(0), in_debug = debug )
  
  return(as.double(r$z_sum))
}


snow_routine_base <- function(P_tsmax, P_trmax, P_DKmax,
                              P_Kmin, P_Tmf, P_SWrf, P_Pns, P_E, P_prof, P_tminseuil,
                              P_tmaxseuil, tmax, tmin, jul, precip, Sdry_in,
                              Swet_in, ps_in, Sdepth_in, in_debug) {
  
  
  r = .Fortran( "snow_routine_dbl", Snowaccu = as.double(0), Snowmelt = as.double(0),
                Sdepth = as.double(0), preciprec = as.double(0), tminrec = as.double(0),
                tmaxrec = as.double(0), Sdry = as.double(0), Swet = as.double(0),
                ps = as.double(0), P_tsmax = as.double(P_tsmax) , P_trmax = as.double(P_trmax),
                P_DKmax = as.double(P_DKmax), P_Kmin = as.double(P_Kmin), P_Tmf = as.double(P_Tmf),
                P_SWrf = as.double(P_SWrf), P_Pns = as.double(P_Pns), P_E = as.double(P_E), 
                P_prof = as.double(P_prof), P_tminseuil = as.double(P_tminseuil),
                P_tmaxseuil = as.double(P_tmaxseuil), tmax = as.double(tmax), tmin = as.double(tmin),
                jul = as.integer(jul), precip = as.double(precip), Sdry_in = as.double(Sdry_in), 
                Swet_in = as.double(Swet_in), ps_in = as.double(ps_in),
                Sdepth_in = as.double(Sdepth_in), in_debug = in_debug)
  
  return(r)
  
  
}



snow_routine <- function(P_tsmax, P_trmax, P_DKmax,
                         P_Kmin, P_Tmf, P_SWrf, P_Pns, P_E, P_prof, P_tminseuil,
                         P_tmaxseuil, tmax, tmin, jul, precip, Sdry_in,
                         Swet_in, ps_in, Sdepth_in, in_debug = FALSE) {
  
  
  
  # Verify inputs dimensions : tmax, tmin, jul, precip
  days_nb <- unique(c(length(tmax),length(tmin),length(jul),length(precip)))
  
  if ( length(days_nb) > 1 ) {
    warning("Some args do not have the same length, aborting !")
    return()
  }
  
  Sdepth <- vector("numeric",days_nb)
  Snowaccu <- Sdepth
  Snowmelt <- Sdepth
  Sdry <- Sdepth
  Swet <- Sdepth
  ps <- Sdepth
  tminrec <- Sdepth
  tmaxrec <- Sdepth
  preciprec <- Sdepth
  
  # loop over days
  for (j in 1:days_nb) {
    
    # launch snow_routine_base
    r <- snow_routine_base(P_tsmax, P_trmax, P_DKmax,
                           P_Kmin, P_Tmf, P_SWrf, P_Pns, P_E, P_prof, P_tminseuil,
                           P_tmaxseuil, tmax[j], tmin[j], jul[j], precip[j], Sdry_in,
                           Swet_in, ps_in, Sdepth_in, in_debug)
    
    # keeping daily values in vectors or df !
    Sdepth[j] <- r$Sdepth
    Snowaccu[j] <- r$Snowaccu
    Snowmelt[j] <- r$Snowmelt
    Sdry[j] <- r$Sdry
    Swet[j] <- r$Swet
    ps[j] <- r$ps
    tminrec[j] <- r$tminrec
    tmaxrec[j] <- r$tmaxrec
    preciprec[j] <- r$preciprec
    
    # update Sdry_in,Swet_in, ps_in, Sdepth_in
    # with values calculates for next day
    Sdry_in <- r$Sdry
    Swet_in <- r$Swet
    ps_in <- r$ps
    Sdepth_in <- r$Sdepth
    
  }
  
  
  # returning a df
  r <- data.frame(Sdepth = Sdepth, Snowaccu = Snowaccu, 
                  Snowmelt = Snowmelt, Sdry = Sdry, Swet = Swet,
                  ps = ps, tminrec = tminrec, tmaxrec = tmaxrec,
                  preciprec = preciprec)
  
  return(r)
  
}




snow_tmin_calc_base <- function(Sdepth, tmin, P_prof, P_tminseuil,
                              P_tmaxseuil ) {
  
  
  r = .Fortran( "tmin_calc_dbl", Sdepth = as.double(Sdepth), tmin = as.double(tmin),
                P_prof = as.double(P_prof), P_tminseuil = as.double(P_tminseuil),
                P_tmaxseuil = as.double(P_tmaxseuil), tminrec = as.double(0))
  
  return(r)
  
  
}


snow_tmin_calc <- function(Sdepth, tmin, P_prof, P_tminseuil,
                           P_tmaxseuil) {

    r <- vapply(Sdepth, function(x) snow_tmin_calc_base(x,tmin,P_prof,
                                                         P_tminseuil,P_tmaxseuil)$tminrec,
                numeric(1)) 
    return(r)
}

snow_tmax_calc_base <- function(Sdepth, tmax, P_prof, P_tminseuil,
                                P_tmaxseuil ) {
  
  
  r = .Fortran( "tmax_calc_dbl", Sdepth = as.double(Sdepth), tmax = as.double(tmax),
                P_prof = as.double(P_prof), P_tminseuil = as.double(P_tminseuil),
                P_tmaxseuil = as.double(P_tmaxseuil), tmaxrec = as.double(0))
  
  return(r)
  
  
}

snow_tmax_calc <- function(Sdepth, tmax, P_prof, P_tminseuil,
                           P_tmaxseuil) {
  
  r <- vapply(Sdepth, function(x) snow_tmax_calc_base(x,tmax,P_prof,
                                                      P_tminseuil,P_tmaxseuil)$tmaxrec,
              numeric(1)) 
  return(r)
}


snow_new_tmin_calc_base <- function(Sdepth, tmin, P_prof, P_tminseuil,
                               P_tmaxseuil ) {
  r <- P_tminseuil - (1 - (Sdepth/P_prof  )) * ( - tmin)
  - (( P_prof  - Sdepth )/ P_prof  ) * P_tminseuil
  
}

