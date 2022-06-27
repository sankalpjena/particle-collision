# Particle Collision

### MacOS/Linux
To run the program:

First give executable rights to `run.sh`

```
chmod +x run.sh
```
Then,

Create a folder `results`

Then, 

```
./run.sh
```

To view the results:

```
python3 postproc/plot.py
```

Note: If you run `plot.py` from inside the `postproc` folder then change the path of `results` to `../results/`

In `plot.py`, the time-steps are read from `input.dat`. The number of particles initialised `Np` needs to be changed.

### Windows

Windows users need to modify the `Makefile`. In line 17, `collide.out` to `collide.exe`.
