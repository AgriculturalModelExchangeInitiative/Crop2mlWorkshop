tminrec=tmin
if (Sdepth_cm  > prof):
    if(tmin  < tminseuil):
        tminrec=tminseuil
    else:
        if (tmin  > tmaxseuil):
            tminrec=tmaxseuil
else:
    if (Sdepth_cm  > 0.0) :
        tminrec=tminseuil-(1-(Sdepth_cm/prof))*(abs(tmin)+tminseuil)
