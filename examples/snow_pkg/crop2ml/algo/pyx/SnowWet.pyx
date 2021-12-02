cdef float frac_sdry, tmp_swet
Swet=0.0
if (Mrf <= Swet_t1) :
    tmp_swet=Swet_t1+(precip-Snowaccu)+M-Mrf
    frac_sdry=0.1*Sdry
    if (tmp_swet  < frac_sdry):
        Swet=tmp_swet
    else:
        Swet=frac_sdry