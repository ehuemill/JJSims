%Explanation of base program

%The program splits a single junciton up into xmax discrete sections.  Each
%section has a supercurrent density, and a phase difference that is
%contributed to by the field (PhaseF), and an arbitrary phase set at x=1
%called Phase1. V000 is just the phase loop to demonstrate that the amount
%of SCurrentNet that can be carried by the junction depends on that Phase1
%value.  By changing the fluxinJunc parameter you can see how the pattern
%is shifted.  Later programs (v001 and beyond) all take the maximum
%SCurrentNet value and record that as the critical current of the junction
%at that field value.  

%This is the exact measurment of the critical current vs field that we 
%do in the lab.  

%% Clearing memory and input screen.
clear; clc; close all;

%% Defining the Parameters of the Simulaiton

    %Dividing the junction up into discrete sections
        xmin = -25;
        xmax =  50;
        xsize=xmax-xmin+1;
        x(1:xsize,1) = (1:xsize)-1+xmin;

    %Defining Super Current parameters
        SCurrentMag = 1;
        SCurrentNoiseMag =.1;

    %Flux Encolsed in the Junction
        FluxinJunc=0;
    
%Setting up Loop steps and ranges
    %Phase Loop parameters
        p=1;
        pmax=202;
        Phase1Min=-2*pi;
        Phase1Max=2.0*pi;

%Calculating Parameters from Initial Conditions
    SCurrentNoise = (SCurrentNoiseMag/(xsize)*(2*rand(xsize,1)-1));
    SCurrentDensity=(SCurrentMag/xsize*ones(xsize,1)+SCurrentNoise);

%Pre Allocating memory to the arrays to decrease runtime
        Phase1=zeros(1,pmax);

        SCurrent=zeros(xsize,pmax);
        SCurrentNet=zeros(1,pmax);


%% Loops for running the simulation Meat of the Simulation

%Field Contribution to the Phase 
    PhaseF=2*pi*FluxinJunc*x./(xsize);
        
%Phase1 Loop of externally set phase at edge of the JJ 
    %Define the loop step size(SS)
        Phase1SS=(Phase1Max-Phase1Min)/(pmax-1); 
    
    %Run the for loop
    for p=1:pmax
        %Calculating the vector that is the Phase contribution from Phase1
        Phase1(p)=Phase1Min+(p-1)*Phase1SS;
        
        %Calculating the total phase drop across the junction
        PhaseDrop=Phase1(p)+PhaseF;
        
        %Calculating the vector that is the Super Current (SCurrent)across
        %the junction at each position.  
        SCurrent=SCurrentDensity.*sin(PhaseDrop);
        
        %Numerically integrating the Super Current (SCurrent) along the
        %junction to find the total super current carried at each Phase1.
        SCurrentNet(p)=sum(SCurrent);
        
    end
   
%Plot the SCurrentNet vs the Phase1 value for the Junction    
figure; plot(Phase1/pi,SCurrentNet,'.');
xlabel ('Phase1 Value/pi');ylabel('Net Super Current Across Junction');
title('Jucntion Supercurrent vs Arbitrary Phase(Phase1) Value');






    




