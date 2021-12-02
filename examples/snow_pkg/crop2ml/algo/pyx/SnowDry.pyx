cdef float tmp_sdry
Sdry=0.0
if (M  <= Sdry_t1) :
    tmp_sdry=Snowaccu+Mrf-M+Sdry_t1
    if (tmp_sdry  < 0.0): 
        Sdry=0.001
    else:
        Sdry=tmp_sdry