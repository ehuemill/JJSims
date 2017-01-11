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

%Defining number of discrete steps in the junction
xmax=101;
x(1,:)=(1:xmax);

%Flux Loop Parameters
f=1;
fmax=601;
FluxinJuncMin=-3;
FluxinJuncMax=3;

SCurrentMag =1;
SCurrentNoiseMag =.9;


%Phase Loop parameters
p=1;
pmax=101;
Phase1Min=-.5*pi;
Phase1Max=1.5*pi;


%Pre Allocating memory to the arrays to decrease runtime
Phase1=zeros(1,pmax);
FluxinJunc=zeros(1,fmax);
IndexMax=zeros(1,fmax);
Phase1MaxSC=zeros(1,fmax);


SCurrentDensity=(SCurrentMag*ones(1,xmax)+SCurrentNoiseMag*(2*rand(1,xmax)-1))/xmax;

SCurrent=zeros(xmax,pmax,fmax);
SCurrentNet=zeros(1,pmax);
MaxSCurrentNet=zeros(1,fmax);

%% Loops for running the simulation Meat of the Simulation


%Field Contribution to the Phase 
%Define the loop step size, then run the for loop
FluxinJuncSS=(FluxinJuncMax-FluxinJuncMin)/(fmax-1);
for f=1:fmax

    FluxinJunc(f)=FluxinJuncMin+(f-1)*FluxinJuncSS;
    PhaseF=2*pi*FluxinJunc(f)*x./xmax;
    
    
%Phase1 Loop of externally set phase at edge of JJ 
    %Define the loop step size, then run the for loop
    Phase1SS=(Phase1Max-Phase1Min)/(pmax-1);
    
    for p=1:pmax
        Phase1(p)=Phase1Min+(p-1)*Phase1SS;
        
        PhaseDrop=Phase1(p)+PhaseF;
        
        SCurrent=SCurrentDensity.*sin(PhaseDrop);
        SCurrentNet(p)=sum(SCurrent);
    end
     
    [MaxSCurrentNet(f),IndexMax(f)]=max(SCurrentNet);
    Phase1MaxSC(f)=Phase1(IndexMax(f));
    [MinSCurrentNet(f),IndexMin(f)]=min(SCurrentNet);
    Phase1MinSC(f)=Phase1(IndexMin(f));
        
end

figure
hold on
subplot(2,1,1); plot(FluxinJunc,MaxSCurrentNet,'.')
ylabel('Critical Current');
hold on
subplot(2,1,2); plot(FluxinJunc,Phase1MaxSC/pi,'.')
xlabel('Flux');ylabel('Phase1 of Ic/pi');


hold on
subplot(2,1,1); plot(FluxinJunc,MinSCurrentNet,'.')
ylabel('Critical Current');
hold on
subplot(2,1,2); plot(FluxinJunc,Phase1MinSC/pi,'.')
xlabel('Flux');ylabel('Phase1 of Ic/pi');

    




