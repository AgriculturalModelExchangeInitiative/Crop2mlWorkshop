# Snow accumulation (unit cm)
cdef float fs=0.0
if (tmax < tsmax): fs=1.0
if ((tmax >= tsmax) and (tmax  <= trmax)):
    fs=(trmax-tmax)/(trmax-tsmax)
Snowaccu=fs*precip 