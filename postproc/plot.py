import numpy as np
import matplotlib.pyplot as plt

# start time, end time, and time-interval of recording the simulation results
nStart = 1
nStop = 3
nStep = 1

# iterate through the time-steps to plot them 
for i in range(nStart, nStop, nStep):
    # read and plot Lagrange points
    file = './results/'+f"{i:06}"+'_P.dat'
    x, y = np.loadtxt(file,unpack=True)   
    plt.scatter(x,y,marker='.',color='k',edgecolors='none',s=10.0)
    plt.pause(0.5)

plt.show()

