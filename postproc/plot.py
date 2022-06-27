from tkinter.font import BOLD
import numpy as np
import matplotlib.pyplot as plt

# importing regex for extracting numbers from input.dat
import re

# for drawing circles
#import matplotlib.patches as mpatches
#from matplotlib.collections import PatchCollection

# read input.dat, extract the number of lines
# source: https://blog.finxter.com/how-to-extract-numbers-from-a-string-in-python/
with open('input.dat') as f:
    lines = f.readlines()
    n_steps = [float(s) for s in re.findall(r'-?\d+\.?\d*', lines[1])] # n_steps is a list

# start time, end time, and time-interval of recording the simulation results
nStart = 1
nStop = int(n_steps[0]) + 1     # change for the number of time-steps, from input.dat, nStop = n_steps + 1
nStep = 1

# plotting circles
Np = 2 # Number of particles

# iterate through the time-steps to plot them 
for i in range(nStart, nStop, nStep):
    # read and plot Lagrange points
    file = './results/'+f"{i:06}"+'_P.dat'
    x, y, r = np.loadtxt(file,unpack=True)

    # instanciating the plots
    fig, ax = plt.subplots()

    # scatter the particle positions
    ax.scatter(x,y,marker='.',color='k',edgecolors='red',s=100)

    # plot circles around the particles
    anotateOffSetX = 0.006
    anotateOffSetY = 0.010
    for p in range(0,Np):
        circles = plt.Circle((x[p],y[p]), r[p], fill=False)
        ax.add_patch(circles)
        text = 'p%i' %(p+1)
        ax.annotate(text,(x[p]+anotateOffSetX,y[p]+anotateOffSetY),size=10,color='b')
    
    # formatting the axes, adding titles
    ax.set_aspect('equal', 'box')
    ax.set(xlim=(0, 1), ylim=(0, 1))
    ax.set_title('Time, t = %i' %(i), fontsize=10)

    # pause the plot before going to the next one
    plt.pause(0.2)

plt.show()

