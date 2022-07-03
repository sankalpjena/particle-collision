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

# 01<sup>nd</sup> June

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

# 03<sup>th</sup> June

Tasks:
1. Python file to read and visualize the location of particles: done! Later: Need to add radius to visualize 
Figure out how to include another column in output files
Need to modify this:
```
write(12,'(2E12.4,A)',rec=ct) P(b)%X(1), P(b)%X(2),P(b)%R, char(10)
```

Read: http://math.hawaii.edu/~gautier/math_190_lecture_11.pdf

2. Cell-list 

# 04<sup>th</sup> June

### Writing output

```
write (filename, "(A8,I6.6,A6)") 'results/', nt, '_P.dat' ! A8 ~ results/, I6.6 ~ 6 spaces with 6 decimal spaces, A6 ~ _P.dat
```
Here, the first argument is the output stream, i.e, the string `filename`. The second argument of `write`, `"(A8,I6.6,A6)"` is the format of the `filename`.

- `A8` : 8 spaces for characters (letter count of 'results/')
- `I6.6` : reserves 6 spaces (including spaces for '.' and any '-') for an integer number (digits in 'nt')
- `A6` : reserves 6 spaces for characters (letter count of '_P.dat')

Read more about formatting here: http://math.hawaii.edu/~gautier/math_190_lecture_11.pdf

In the following code, the result files are opened in direct access mode. The record length `recl` is important. Since we write 3 data: location and radius of particles and an empty line, we have `recl = 3 * 12 + 1 = 37`
```
fmt = '(3E12.4,A)' ! 3 f/E float/scientificNotation values, 1 character string of unspecified length

open(unit=12, file = trim(filename), access='direct', recl=37, form='formatted') !recl = 3 * 12 (#type E * #spaces for each type) + 1 (character strings of unspecified length)
    ct=0
    do b=1,Np
        ct=ct+1
        write(12,fmt,rec=ct) P(b)%X(1), P(b)%X(2), P(b)%R, char(10) ! rec ... record number needed for direct access data transfer
    end do
  close(12)
  ```

  # OOP in Fortran

  source : https://cyber.dabamos.de/programming/modernfortran/object-oriented-programming.html

  Problem in particleSet with constructor. Tommorow work on how to implement the constructor


# 08<sup>th</sup> June

For now, created an array of particles 'P'. Now, working on cellList.
Two issues to resolve: 
1. Need implementation of linked list in Fortran. So, that when new particle corresponding to a 
cell is found, we need to add them.
2. Dictionary to store the indices of particles corresponding to a cell. I think, a linked 
list would solve this issue as well. NO IT WON'T!


# 17<sup>th</sup> June

Dropping the cell-list implementation. Search for all the collisions by checking for all of the 
particles' interaction with every other particle. The cost would be O(N^2).

# 18<sup>th</sup> June

Summary till now: I have 4 particles. Now, I need to know the overlap of every particle with each other.
To find the overlap, I need to know the distance between two particles (L2 norm), check whether they overlap $d_{pq} = (R_p + R_q) - \lvert \underbar{x}_p - \underbar{x}_q \rvert$

In module `moduleOverlap`, there are two functions: `distance()` and `overlap()`. They are based on the formula:
$$ \lvert \underbar{x}_p - \underbar{x}_q \rvert = \sqrt{ (x_p - x_q)^2 + (y_p - y_q)^2 } $$
and 
$$ d_{pq} = (R_p + R_q) - \lvert \underbar{x}_p - \underbar{x}_q \rvert $$

*12:15* Implemented the overlap calculations and verified with manual calculation. See notes (Beleg/Code). 

Now, need to implement the contact laws. Here, if the deformation is positive, i.e, distance between two particles is greater than the sum of their radius, then apply contact law. Otherwise, do not interact them as they are separated. 

In solve(), all of the interaction is being done.

Modified plot.py, to read `input.dat` to extract the `n_steps`.

# 26<sup>th</sup> June

Working on the forces.

Wrote listing 4.8, but need to verify them.

Next time-integration scheme.

# 27<sup>th</sup> June

In the `interact` subroutine, the collisions are detected. Corresponding overlaps are computed. Using the formulation in 
https://aip.scitation.org/doi/pdf/10.1063/1.1487379, forces are computed. From the forces, acceleration (force/mass) is computed, then the velocity calculated by Explicit Euler integration. Similarly, for angular velocity. Finally, the position is calculated by integrating the velocity.

The calculations have not been verified. Need to figure out the time-steps.

# 03<sup>th</sup> July

Problem of overlap: To control the maximum overlap, the normal stiffness coefficient needs to be modified according to $$ k_n \sim m (\frac{v_{max}}{x_{max}})^2$$ Eq. (4) Schwarz et. al.

For $k_r = 450$ in `module_globalVariables.F90` and `dt = 0.1` in `input.dat` the solution looks physical till $t=1.25$, and then diverges. I expected that upon decreasing `dt` the solution should converge, but it diverges completely.