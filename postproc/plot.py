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

# time-stepping
dt = delta_t[0]
t_end = t_end[0]

# plotting circles
Np = 2 # Number of particles


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
    plt.pause(0.000001)

plt.show()



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


# animation of collision
"""
fig = plt.figure()
ax = plt.axes(xlim=(0, 4), ylim=(-2, 2))
line, = ax.plot([], [], lw=3)

# initialize a variable line which will contain the x and y co-ordinates of the plot
def init():
    line.set_data([], [])
    return line,

# i ~ frame number 
def animate(i):
    x = np.linspace(0, 4, 1000)
    y = np.sin(2 * np.pi * (x - 0.01 * i))
    line.set_data(x, y)
    return line,

anim = FuncAnimation(fig, animate, init_func=init,
                               frames=2, interval=1, blit=True)


anim.save('sine_wave.gif', writer='imagemagick')

"""

"""
dt = 0.01
tfinal = 1
x0 = 0

sqrtdt = np.sqrt(dt)
n = int(tfinal/dt)
xtraj = np.zeros(n+1, float)
trange = np.linspace(start=0,stop=tfinal ,num=n+1)
xtraj[0] = x0

for i in range(n):
    xtraj[i+1] = xtraj[i] + np.random.normal()

x = trange
y = xtraj

# animation line plot example

fig, ax = plt.subplots(1, 1, figsize = (6, 6))

def animate(i):
    ax.cla() # clear the previous image
    ax.plot(x[:i], y[:i]) # plot the line
    ax.set_xlim([x0, tfinal]) # fix the x axis
    ax.set_ylim([1.1*np.min(y), 1.1*np.max(y)]) # fix the y axis


anim = FuncAnimation(fig, animate, frames = len(x) + 1, interval = 1, blit = False)
plt.show()

#anim.save('timeSeries.gif', writer='imagemagick')
"""