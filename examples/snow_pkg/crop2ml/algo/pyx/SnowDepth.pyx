# Snow depth calculation
Sdepth=0.0
if(Snowmelt  <= (Sdepth_t1+Snowaccu/rho)): 
    Sdepth=(Snowaccu/rho+Sdepth_t1-Snowmelt-(Sdepth_t1*E))