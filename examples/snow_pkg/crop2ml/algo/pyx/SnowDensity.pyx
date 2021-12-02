# ps calculation
ps=0.0
if ( abs(Sdepth_t1)  > 0.0 ):
    if ( abs( Sdry_t1 +  Swet_t1 )  > 0.0 ):
        ps = ( Sdry_t1 +  Swet_t1 )  / Sdepth_t1
    else:
        ps=ps_t1
