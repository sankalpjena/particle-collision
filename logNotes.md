# Log of programming 

# 31<sup>th</sup> May
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

##### Random number generator:
https://masuday.github.io/fortran_tutorial/random.html

- note that the random number(s) are stored in the variable that is passed to the generator and are of the same type as of the variable

```
call random_number(p(i)%X)
```

`X` is of dimension `2` so two random numbers are generated and assigned to `X`

# 02<sup>nd</sup> June

##### Time Integration

 We can't use RK-4 time-integration since it is embedded into the fluid solver. Instead we can use explicit time integration schemes. First, we will try with Explicit Euler, then with RK-4.

 #### I/O files

 `output.F90` is used to export the result to be post-processed in Python.

To create output we need to solve firt, so created a dummy `solve` and then called `solve`. Since we need to 
progress in time to integrate, `module_globalVariables` was created to have the time and time-steps.


Note: Remember to add newly created files to the `Makefile` so that they are compiled otherwise you could get errors like this.
```
(data_sc_env) sankalp@jenambp collisionV1 % make collision
gfortran module_particle.F90 initialize.F90 collide.F90 -O3 -w -o collision.out
collide.F90:10:6:

   10 |  use moduleGlobalVariables
      |      1
Fatal Error: Cannot open module file 'moduleglobalvariables.mod' for reading at (1): No such file or directory
compilation terminated.
make: *** [collision] Error 1

```

Added `solve()` to `collide` so that `output` is called. For now only 

Added reading of `input.dat` in `initialize`. Note that the old result files need to be removed in `initialize`

A silly mistake: I removed the last line of the `input.dat` file, and program compilation suddenly gave the error
```
At line 18 of file initialize.F90 (unit = 1, file = 'input.dat')
Fortran runtime error: End of file

Error termination. Backtrace:
#0  0x10d213e9e
#1  0x10d214b45
#2  0x10d21572b
#3  0x10d436e43
#4  0x10d437fe5
#5  0x10d43a999
#6  0x10d43ac3d
#7  0x10cdde0e7
#8  0x10cdde384
#9  0x10cdde8ce
```
It said **Fortran runtime error: End of file**, so I had to add back the empty line :)

# 04<sup>th</sup> June

Tasks:
1. Python file to read and visualize the location of particles: done! Later: Need to add radius to visualize 
2. Cell-list 