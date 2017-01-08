# JJSims

This program is for simulating the behavior of Josephson juctions and SQUIDS.
It calculates the critical current of the devices in the presence of magnetic field with a 
variety of differnt other parameters that can be tuned.

The other parameter that is tuned is just another loop, and so the and IC vs Phi graph can be made.  
The Ic vs Phi graph can have several steps in the magnitude of the other parameter.

The simulation is written in Matlab, although a good project for learning how to program in python would be to 
write this content in that language..

Version 001 is the fundemental base that only has the super current vs field graph as the output
Version 002 is the next step in the process and includes a phase offset for half of the junction (like dwave junctions).
Version 003 is the first stab at making a squid loop included in the simulation
Version 004 adds other realistic features of the simulation
Version 005 rewrote the functionality of 004 but with two separate junctions to clean up the code
Version 006 was reformated so that it can be done with parfor comands and plots the phase of the max SC


If you are starting a new application, start a branch (most likeley from 002) and knock your self out!


