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


%Version 003 was adapted to add a squid loop into the middle of the
%junction by including an area that would add to the overall phase of the 
%part of the junction that is past the location of the loop.  The loop size
%can be varied, as can the relative critical currents between the two areas
%



%% Clearing memory and input screen.

clear;
clc;
close all;

%% Defining the Parameters of the Simulaiton
xmax1=201;
x1(1,:)=(1:xmax1);

xmax2=201;
x2(1,:)=(1:xmax2);

LoopArea=1;


%Field Parameters
f=1;
fmax=1001;
FieldMin=-5;
FieldMax=5;


%Phase Loop parameters
p=1;
pmax=201;
Phase1Min=0*pi;
Phase1Max=4*pi;


%Pre Allocating memory to the arrays to decrease runtime
Phase1=zeros(1,pmax);
FluxinJunc1=zeros(1,fmax);
FluxinJunc2=zeros(1,fmax);
FluxinLoop=zeros(1,fmax);

SCurrentDensityNoise=(2*rand(1,xmax)-1);
SCurrentDensity=ones(1,xmax)+.01*SCurrentDensityNoise;


SCurrent=zeros(xmax,pmax,fmax);
SCurrentNet=zeros(1,pmax);
MaxSCurrentNet=zeros(1,fmax);
MinSCurrentNet=zeros(1,fmax);
%% Loops for running the simulation Meat of the Simulation



%Field Contribution to the Phase 
%Define the loop setp size, then run the for loop
FluxinJuncSS=(FluxinJuncMax-FluxinJuncMin)/(fmax-1);
for f=1:fmax

    FluxinJunc(f)=FluxinJuncMin+(f-1)*FluxinJuncSS;
    PhaseF=2*pi*x./xmax*FluxinJunc(f);
    
    FluxinLoop(f)=FluxinJuncMin+(f-1)*FluxinJuncSS;
    PhaseL=2*pi*LoopArea*FluxinLoop(f);
    
    %Phase1 Loop of externally set phase 
    %Define the loop setp size, then run the for loop
    Phase1SS=(Phase1Max-Phase1Min)/(pmax-1);
    for p=1:pmax

        Phase1(p)=Phase1Min+(p-1)*Phase1SS;
        PhaseDrop=PhaseF+Phase1(p)+PhaseL;
        SCurrent=SCurrentDensity.*(sin(PhaseDrop));
        SCurrentNet(p)=sum(SCurrent)/xmax;


    end

    MaxSCurrentNet(f)=max(SCurrentNet);
    MinSCurrentNet(f)=min(SCurrentNet);
end


figure
plot(FluxinJunc,MaxSCurrentNet,'r.')
hold on 
plot(FluxinJunc,MinSCurrentNet,'g.')




    




