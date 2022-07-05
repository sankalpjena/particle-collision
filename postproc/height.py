import numpy as np
import matplotlib.pyplot as plt

# importing regex for extracting numbers from input.dat
import re

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

# time-stepping
dt = delta_t[0]
t_end = t_end[0]

# plotting circles
Np = 2 # Number of particles

# plotting the variation of height
#print("no of files", int((nStop - nStart)/nt_out))
numFiles = int((nStop - nStart)/nt_out)
height = np.zeros(numFiles)
time = np.zeros(numFiles)
#print("dt", t_end/nStep)
#print(dt)
time = np.linspace(0,int(t_end),numFiles)
#print('size of height',np.size(height))
#print('size of time',np.size(time))
#print('Time',time)
#print('nstart',nStart)
#print('nstop', nStop)
#print('nStep',nStep)

for i in range(nStart, nStop,nStep):
     # read and plot Lagrange points
    file = './results/'+f"{i:06}"+'_P.dat'
    x, y, r, vx, vy = np.loadtxt(file,unpack=True)
    #print(y[0])
    #print(int((i-nStep)/nStep))
    height[int((i-nStep)/nStep)] = y[0]
    

#print(height)
#print(time)


ax = plt.axes()
ax.plot(time,height,color='blue',linestyle='dashdot',label='Simulation')
ax.set(xlim=(0, time[-1]), ylim=(0,1.5),         #ylim=(min(height) - 1, max(height) + 1)
       xlabel='Time[s]', ylabel='Height[m]',
       title='Bouncing Ball');
plt.legend()
plt.show()
