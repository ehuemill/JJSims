%Explanation of base program

%The program splits a single junciton up into xmax discrete sections.  Each
%section has a supercurrent density, and a phase difference that is
%contributed to by the field (PhaseF), and an arbitrary phase set at x=1
%called Phase1.  For each value of field and Phase1 the supercurrent at
%each point is calculated and the net supercurrent (sum along the junction)
%is calcualted to find the supercurrent carried at that phase and that
%field.  To find the maximum supercurrent for a given field, the max of
%that vector is taken, and can be plotted against the magnetic field.  This
%is the exact measurment of the critical current vs field that we do in the
%lab.  

%% Clearing memory and input screen.
clear;
clc;
close all;
%% Defining the Parameters of the Simulaiton

    %Dividing the junction up into discrete sections
    xmax=101;
    x(1,:)=(1:xmax);

    %Defining Super Current parameters
    SCurrentMag =1;
    SCurrentNoiseMag =.1;


%Setting up Loop steps and ranges

    %Phase Loop parameters
    p=1;
    pmax=202;
    Phase1Min=-2*pi;
    Phase1Max=2.0*pi;

    %Flux Encolsed in the Junction
    FluxinJunc=.5;

%Calculating Parameters from Initial Conditions

    SCurrentDensity=(SCurrentMag*ones(1,xmax)/xmax+SCurrentNoiseMag/xmax*(2*rand(1,xmax)-1));

%Pre Allocating memory to the arrays to decrease runtime
    Phase1=zeros(1,pmax);

    SCurrent=zeros(xmax,pmax);
    SCurrentNet=zeros(1,pmax);


%% Loops for running the simulation Meat of the Simulation


%Field Contribution to the Phase 
    PhaseF=2*pi*FluxinJunc*x./xmax;
    
    
%Phase1 Loop of externally set phase at edge of JJ 
    %Define the loop step size, then run the for loop
    Phase1SS=(Phase1Max-Phase1Min)/(pmax-1);
    
    for p=1:pmax
        Phase1(p)=Phase1Min+(p-1)*Phase1SS;
        
        PhaseDrop=Phase1(p)+PhaseF;
        
        SCurrent=SCurrentDensity.*sin(PhaseDrop);
        SCurrentNet(p)=sum(SCurrent);
    end
     
    [MaxSCurrentNet,IndexMax]=max(SCurrentNet);
    Phase1MaxSC=Phase1(IndexMax);
        

figure

plot(Phase1/pi,SCurrentNet,'.')
xlabel ('Phase1 Value/pi');ylabel('Total Super Current Across Junction');






    




