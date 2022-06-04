import numpy as np
import matplotlib.pyplot as plt

# for drawing circles
import matplotlib.patches as mpatches
from matplotlib.collections import PatchCollection

# start time, end time, and time-interval of recording the simulation results
nStart = 1
nStop = 3
nStep = 1

# position of particle
pos = np.zeros(2)
patches = []
# iterate through the time-steps to plot them 
for i in range(nStart, nStop, nStep):
    # read and plot Lagrange points
    file = './results/'+f"{i:06}"+'_P.dat'
    x, y, r = np.loadtxt(file,unpack=True)
    plt.scatter(x,y,marker='.',color='k',edgecolors='red',s=100)
    pos = [0,0]
    r = 1
    print(pos)
    print(r)
    # add a circle
    circle = mpatches.Circle(pos, r, ec="none")
    patches.append(circle)
    #label(pos, "Circle")
    plt.pause(0.5)

plt.show()

