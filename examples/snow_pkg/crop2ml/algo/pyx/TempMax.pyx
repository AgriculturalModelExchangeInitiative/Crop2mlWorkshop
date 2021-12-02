tmaxrec=tmax
if (Sdepth_cm  > prof):
    if(tmax  < tminseuil):
        tmaxrec=tminseuil
    else:
        if (tmax  > tmaxseuil):
            tmaxrec=tmaxseuil
else:
    if (Sdepth_cm  > 0.0):
        if (tmax  <= 0.0):
            tmaxrec=tmaxseuil-(1-(Sdepth_cm/prof))*(-tmax)
        else:
            tmaxrec=0.0