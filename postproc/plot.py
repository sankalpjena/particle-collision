from cProfile import label
from tkinter import NS
from tkinter.font import BOLD
import numpy as np
import matplotlib.pyplot as plt

# importing regex for extracting numbers from input.dat
import re

# animation
import matplotlib.animation as ani

# for drawing circles
#import matplotlib.patches as mpatches
#from matplotlib.collections import PatchCollection

# read input.dat, extract the number of lines
# source: https://blog.finxter.com/how-to-extract-numbers-from-a-string-in-python/
with open('input.dat') as f:
    lines = f.readlines()
    n_steps = [float(s) for s in re.findall(r'-?\d+\.?\d*', lines[1])] # n_steps is a list
    delta_t = [float(s) for s in re.findall(r'-?\d+\.?\d*', lines[3])]

# start time, end time, and time-interval of recording the simulation results
nStart = 1
nStop = int(n_steps[0]) + 1     # change for the number of time-steps, from input.dat, nStop = n_steps + 1
nStep = 1

# time-stepping
dt = delta_t[0]
#print('dt :', dt)

# plotting circles
Np = 2 # Number of particles

"""
# iterate through the time-steps to plot them 
for i in range(nStart, nStop, nStep):
    # read and plot Lagrange points
    file = './results/'+f"{i:06}"+'_P.dat'
    x, y, r, vx, vy = np.loadtxt(file,unpack=True)

    # instanciating the plots
    fig, ax = plt.subplots()

    # scatter the particle positions
    ax.scatter(x,y,marker='.',color='k',edgecolors='red',s=100)

    # plot the velocity vectors
    plt.quiver(x,y,vx,vy)

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
    ax.set(xlim=(-1.5, 1.5), ylim=(-1, 1))
    ax.set_title('Time, t = %i' %(i), fontsize=10)

    # pause the plot before going to the next one
    plt.pause(0.2)

plt.show()
"""

# plotting the variation of height
height = np.zeros(nStop-1)
time = np.zeros(nStop-1)
#print(np.size(height))

for i in range(nStart, nStop, nStep):
     # read and plot Lagrange points
    file = './results/'+f"{i:06}"+'_P.dat'
    x, y, r, vx, vy = np.loadtxt(file,unpack=True)
    #print(y[0])
    height[i-1] = y[0]
    time[i-1] = time[i-1] + (i-1) * dt

#print(height)
#print(time)

ax = plt.axes()
ax.plot(time,height,color='blue',linestyle='dashdot',label='Simulation')
ax.set(xlim=(0, time[-1]), ylim=(0, 1.5),         #ylim=(min(height) - 1, max(height) + 1)
       xlabel='Time[s]', ylabel='Height[m]',
       title='Bouncing Ball');
plt.legend()
plt.show()