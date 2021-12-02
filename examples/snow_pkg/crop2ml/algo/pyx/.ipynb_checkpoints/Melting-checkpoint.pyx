# M calculation
cdef float K
M = 0.0
K=(DKmax/2.0)*(-sin((2.0*pi*float(jul)/366.0)+(9.0/16.0)*pi)) +Kmin+(DKmax/2.0)

if ( tavg  > Tmf ): 
    M = K * ( tavg - Tmf )