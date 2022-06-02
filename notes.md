# Notes on programming 

### 1. The structure of the program

The **_make_** utility uses `Makefile` to define the set of tasks to be used. 

```
collision:
	$(FC) $(FILES) -O3 -w -o collision.out
all: collision
```
Upon typing `make collision` in the terminal, the string `$(FC) $(FILES) -O3 -w -o collision.out` is executed. Here, `$(FC)` refers to the compiler, `$(FILES)` refers to the source files to be used in the compilation. Other things are the optimisation flag `-O3`, with warnings `-w`, and finally the `-o` linking of object files to generete the executable `collision.out`. In linux systems, the `collision.out` is executed by `./collision.out`.

As of now, there are three source files.
```
FILES = module_particle.F90      \
        initialize.F90               \
        collide.F90
```

The `structure` in lingo of FORTRAN, is similar to `classes` of `C++`. 

The particle data structure has been declared in the the `module` `module_particle.F90`. A particle has following properties: 

- position
- radius
- mass
- polar moment of inertia
- velocity
- angular velocity
- deformation


File `initialize.F90` is a subroutine. It is called by the main file i.e. `program`, `collide.F90`. In this subroutine, the particles are initialised with their properties. To sum it up, the particle data structure is declared in `module_particle.F90` and particles are defined in `initialize.F90`. 

Next steps: create 5 particles, generate the cell-list, output the results, view the data using python

#####Random number generator:
https://masuday.github.io/fortran_tutorial/random.html

- note that the random number(s) are stored in the variable that is passed to the generator and are of the same type as of the variable

```
call random_number(p(i)%X)
```

`X` is of dimension `2` so two random numbers are generated and assigned to `X`

Side note: We can't use RK-4 time-integration since it is embedded into the fluid solver. Instead we can use explicit time integration schemes. First, we will try with Explicit Euler, then with RK-4.