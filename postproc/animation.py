from cProfile import label
from tkinter import NS
from tkinter.font import BOLD
import numpy as np
import matplotlib.pyplot as plt

# importing regex for extracting numbers from input.dat
import re

# animation
from matplotlib.animation import FuncAnimation
plt.style.use('seaborn-pastel')

# for drawing circles
#import matplotlib.patches as mpatches
#from matplotlib.collections import PatchCollection

# read input.dat, extract the number of lines
# source: https://blog.finxter.com/how-to-extract-numbers-from-a-string-in-python/
with open('input.dat') as f:
    lines = f.readlines()
    n_steps = [float(s) for s in re.findall(r'-?\d+\.?\d*', lines[1])] # n_steps is a list
    delta_t = [float(s) for s in re.findall(r'-?\d+\.?\d*', lines[3])]
    nt_out = [float(s) for s in re.findall(r'-?\d+\.?\d*', lines[4])]
    t_end = [float(s) for s in re.findall(r'-?\d+\.?\d*', lines[2])]

# start time, end time, and time-interval of recording the simulation results
nt_out = int(nt_out[0])
nStart = nt_out
nStop = int(n_steps[0]) + nt_out     # change for the number of time-steps, from input.dat, nStop = n_steps + 1
nStep = nt_out

# Debugging values
#nStop = 5000
#nStep = 500

# time-stepping
dt = delta_t[0]
t_end = t_end[0]

# plotting circles
NpWall = 500
Np = 20
NpTotal = Np + NpWall # Number of particles

# image index
imIdx = 0

# iterate through the time-steps to plot them 
for i in range(nStart, nStop, nStep):
    # read and plot Lagrange points
    file = './results/'+f"{i:06}"+'_P.dat'
    x, y, r, vx, vy = np.loadtxt(file,unpack=True)

    # instanciating the plots
    fig, ax = plt.subplots()

    # scatter the particle positions
    ax.scatter(x,y,marker='.',color='k')#,edgecolors='red',s=10)

    # plot the velocity vectors
    #plt.quiver(x,y,vx,vy)

    # plot circles around the particles
    anotateOffSetX = 0.006
    anotateOffSetY = 0.010
    for p in range(0,NpTotal):
        circles = plt.Circle((x[p],y[p]), r[p], fill=False)
        ax.add_patch(circles)
    
    for p in range(0,Np):
        text = 'p%i' %(p+1)
        ax.annotate(text,(x[p]+anotateOffSetX,y[p]+anotateOffSetY),size=10,color='b')
    
    
    # formatting the axes, adding titles
    ax.set_aspect('equal', 'box')
    ax.set(xlim=(-2, 6), ylim=(-1, 4))
    ax.set_title('Time-Step, t = %i' %(i), fontsize=10)

    # pause the plot before going to the next one
    #plt.pause(0.000001)
    
    plt.savefig("./plots/image{imIdx}.png".format(imIdx=imIdx),dpi=800)
    imIdx += 1


