# fortran compiler
FC = gfortran

# list own files
FILES = module_globalVariables.F90 \
		module_particle.F90      \
        initialize.F90               \
		module_overlap.F90 \
		module_contactLaw.F90 \
		deallocation.F90 \
		solve.F90 \
		output.F90 \
		collide.F90 

# build
collide:
	$(FC) $(FILES) -O3 -w -o collide.out

all: collide
	
# clean up
clean:
	rm -f *.o *.mod *.MOD *.out
	rm -f ./results/*

# clean up
clean_data:
	rm -f ./results/*
