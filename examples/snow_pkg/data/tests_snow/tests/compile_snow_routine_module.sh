if ! [ -e lib ]
then
  mkdir lib
fi

R CMD SHLIB -o ./lib/libsnowroutine.so ./../src/Snow_Processes.f90 ./../src/Snow_routine_module.f90  -L../../lib
