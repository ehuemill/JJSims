# JJSims

This program is for simulating the behavior of Josephson juctions and SQUIDS.
It calculates the critical current of the devices in the presence of magnetic field with a 
variety of differnt other parameters that can be tuned.

The other parameter that is tuned is just another loop, and so the and IC vs Phi graph can be made.  
The Ic vs Phi graph can have several steps in the magnitude of the other parameter.

The simulation is written in Matlab, although a good project for learning how to program in python would be to 
write this content in that language..

If you are just starting out with these simulations, look at "Simplest Junction" first to understand fundementally how 
the program works.  Then move on to the "Simplest Squid" program where more functionality is included, but you can still
look at single junction behavior (Loop length=0 will do it).  Once you unerstand that, move on to "Full Squid" simulations.  

The "Full Squid with Phase loop" should be easier to follow than "Full Squid No Phase Loop" because the phase loop is explicityly 
run through.  The "No Phase Loop" version was made to try out paralell computing (parfor comand on Field loop).  In tests
there was no speed up for simulations that ran less than 3 min acording to the "run and time" feature in matlab. 

Version 001 is the fundemental base that only has the super current vs field graph as the output
Version 002 is the next step in the process and includes a phase offset for half of the junction (like dwave junctions).
Version 003 is the first stab at making a squid loop included in the simulation
Version 004 adds other realistic features of the simulation
Version 005 rewrote the functionality of 004 but with two separate junctions to clean up the code
Version 006 was reformated so that it can be done with parfor comands and plots the phase of the max SC

