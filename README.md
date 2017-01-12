# JJSims

This program is for simulating the behavior of Josephson juctions and SQUIDS.
It numerically calculates the critical current of the devices in the presence of magnetic field with a 
variety of differnt other parameters that can be tuned.

The simulation is written in Matlab, although a good project for learning how to program in python would be to 
write this content in that language.

If you are just starting out with these simulations, look at "Simplest Junction" first to understand fundementally how 
the program works.  Once you understand the basic process of the program, move on to "Single Junction Sim" to
see how to run the simulation while changing another parameter.

For people interested in SQUID simulations, still start at "Simplest Junction" and then go to "Simmplest SQUID".
This way you will first understand what the program does with a single junction, and then how the second junction
and the squid loop are integrated into the calculation.  

See if you can find the parameters needed to get the "Simplest SQUID" simulation output to look like the
output from "Simplest Junction.

When you figuer that out, move on to "Full SQUID" simulations.  V005 will be easier to follow than 006 because it 
explicity runs through the phase loop.  In v006 the phase loop is combined into the variables as another dimension. 
This enables matlab to do its thing on matricies, but also alows you to add 'parfor' instead of the 'for' command in the 
'f' loop to paralellize the program.  Once the simulation time gets above 3 min, paralellizing makes it run faster.

Version 001 is the fundemental base that only has the super current vs field graph as the output
Version 002 is the next step in the process and includes a phase offset for half of the junction (like dwave junctions).
Version 003 is the working version of the single junction simulation. 
Version 004 is the simpliest version of a SQUID simulation
Version 005 is the working version with an explicity phase loop that is run through
Version 006 was reformated so that it can be done with parfor comands and plots the phase of the max SC

