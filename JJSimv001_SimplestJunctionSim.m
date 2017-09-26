%Explanation of base program

%The program splits a single junciton up into xmax discrete sections.  Each
%section has a supercurrent density, and a phase difference that is
%contributed to by the field (PhaseF), and an arbitrary phase set at x=1
%called Phase1.  For each value of field and Phase1 the supercurrent at
%each point is calculated and the net supercurrent (sum along the junction)
%is calcualted to find the supercurrent carried at that phase and that
%field.  To find the maximum supercurrent for a given field, the max of
%that vector is taken, and can be plotted against the magnetic field.  


%This is the exact measurment of the critical current vs field that we do in the
%lab.  

%% Clearing memory and input screen.
clear; clc; close all;

%% Defining the Parameters of the Simulaiton
    %Dividing the junction up into discrete sections
        xmin = -20;
        xmax =  20;
        xsize=xmax-xmin+1;
        x(1:xsize,1) = (1:xsize)-1+xmin;

    %Defining Super Current parameters
        SCurrentMag =1;
        SCurrentNoiseMag =.01;

%Setting up Loop steps and ranges
    %Phase Loop parameters
        p=1;
        pmax=501;
        Phase1Min = -0.0 * pi;
        Phase1Max =  4.0 * pi;
        %Phase1 is the phase at x=0.  
    %Flux Loop Parameters
        f=1;
        fmax=501;
        FluxinJuncMin= -3.5;
        FluxinJuncMax=  3.5 ;

%Calculating Parameters from Initial Conditions
    SCurrentNoise   = (SCurrentNoiseMag/xsize*(2*rand(xsize,1)-1));
    SCurrentDensity = (SCurrentMag/xsize*ones(xsize,1)+SCurrentNoise);
    
%Pre Allocating memory for the arrays to decrease runtime
    Phase1=zeros(1,pmax);
    FluxinJunc=zeros(1,fmax);
    IndexMax=zeros(1,fmax);
    Phase1MaxSC=zeros(1,fmax);

    SCurrent=zeros(xsize,pmax,fmax);
    SCurrentNet=zeros(1,pmax);
    MaxSCurrentNet=zeros(1,fmax);

%% Loops for running the simulation Meat of the Simulation


%Field Contribution to the Phase 
    %Define the loop step size, then run the for loop
    FluxinJuncSS=(FluxinJuncMax-FluxinJuncMin)/(fmax-1);
    for f=1:fmax
        FluxinJunc(f)=FluxinJuncMin+(f-1)*FluxinJuncSS;
        PhaseF=2*pi*FluxinJunc(f)*x./xsize;

        %Phase1 Loop of externally set phase at edge of JJ 
            %Define the loop step size(SS)
                Phase1SS=(Phase1Max-Phase1Min)/(pmax-1); 

            for p=1:pmax
                %Calculating Phase1(p) that is the abitrary Phase at x=0
                Phase1(p)=Phase1Min+(p-1)*Phase1SS;

                %Calculating the total phase drop across the junction
                PhaseDrop=Phase1(p)+PhaseF;

                %Calculating the vector that is the Super Current (SCurrent)
                %across the junction at each position.  
                SCurrent=SCurrentDensity.*(.8.*sin(PhaseDrop)+0.2.*sin(PhaseDrop/2));
               
                %Numerically integrating the Super Current (SCurrent) along 
                %the junction to find the total super current carried at 
                %each Phase1.
                SCurrentNet(p)=sum(SCurrent);
            end

            
            %Finding the Magnitude and the Index(Phase1 Value) of the 
            %Supercurrent across the junction at the current field strength
            [MaxSCurrentNet(f),IndexMax(f)]=max(SCurrentNet);
            %Recording the Phase1 value of the maximum super current
            Phase1MaxSC(f)=Phase1(IndexMax(f));

    end

%Ploting the maximum supercurrent vs the field in the junction
figure; subplot(2,1,1); plot(FluxinJunc,MaxSCurrentNet,'.')
ylabel('Critical Current');

%Ploting the Phase1 value that maximizes the critical current
subplot(2,1,2); plot(FluxinJunc,Phase1MaxSC/pi,'.')
xlabel('Flux');ylabel('Phase1 of Ic/pi');




    




