preciprec = precip
if ((Sdry+Swet)<(Sdry_t1+Swet_t1)):
    preciprec=preciprec+(Sdepth_t1-Sdepth)*rho-Mrf
preciprec=preciprec-Snowaccu