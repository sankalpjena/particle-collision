# fortran compiler
FC = gfortran

# list own files
FILES = module_particle.F90      \
        initialize.F90               \
        collide.F90

# build
collision:
	$(FC) $(FILES) -O3 -w -o collision.out

all: collision
	
# clean up
clean:
	rm -f *.o *.mod *.MOD *.out
	rm -f ./results/*

# clean up
clean_data:
	rm -f ./results/*
