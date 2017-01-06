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
% Version 004 Was adapted so that there were two totally separate junctions
% that both can modulate, but that the phases are pinned together at one
% end through the squid loop area. This simulation includes junction area
% asymmetry, junction critical current asymmetry, 



%Abreviations used
%Junction=Junc
%Super Current = SCur or just SC
%Step Size = SS sufix
%Width = Wid
%Length = Len
%Magnitude = Mag


%% Clearing memory and input screen
% 
% clear;
% clc;
% close all;

%% Defining the Parameters of the Simulaiton

%Setting Junction 1 Parameters
xmax1=101;
x1(1,:)=(1:xmax1);
JuncSCMag1=1;
JuncWid1=.5;
JuncLen1=1;
JuncArea1=JuncWid1*JuncLen1;

SCurNoise1=(2*rand(1,xmax1)-1);
SCurDen1=JuncSCMag1*ones(1,xmax1)/xmax1+.01*SCurNoise1/xmax1;

%Setting Junction 2 Parameters
xmax2=101;
x2(1,:)=(1:xmax2);
JuncSCMag2=50;
JuncWid2=.5;
JuncLen2=1;
JuncArea2=JuncWid2*JuncLen2;

SCurNoise2=(2*rand(1,xmax2)-1);
SCurDen2=JuncSCMag2*ones(1,xmax2)/xmax2+.01*SCurNoise2/xmax2;

%Setting Squid Loop Parameers
LoopWid=10;
LoopLen=10;
LoopArea=LoopWid*LoopLen;

%Field Parameters
f=1;
fmax=1001;
FieldMin=-.03;
FieldMax=.03;


%Phase Loop parameters
p=1;
pmax=401;
Phase0Min=0*pi;
Phase0Max=4*pi;


%Pre Allocating memory to the arrays (should decrease runtime)
Phase0=zeros(1,pmax);
Field=zeros(1,fmax);
FluxinJunc1=zeros(1,fmax);
FluxinJunc2=zeros(1,fmax);
FluxinLoop=zeros(1,fmax);

PhaseFDen1=zeros(1,fmax);
PhaseFDen2=zeros(1,fmax);
PhaseFL=zeros(1,fmax);

SCurrent1=zeros(xmax1,pmax,fmax);
SCurrent2=zeros(xmax2,pmax,fmax);
SCurrentNet=zeros(1,pmax);

MaxSCurrentNet=zeros(1,fmax);
MinSCurrentNet=zeros(1,fmax);
%% Loops for running the simulation Meat of the Simulation



%Field Contribution to the Phase 
%Define the Field ForLoop setp size, then run the Field for ForLoop
FieldSS=(FieldMax-FieldMin)/(fmax-1);
for f=1:fmax

    Field(f)=FieldMin+(f-1)*FieldSS;
    
    
    PhaseF1=2*pi*Field(f)*JuncArea1;
    PhaseF2=2*pi*Field(f)*JuncArea2;
    PhaseFL=2*pi*Field(f)*LoopArea;
    
    PhaseFDen1=PhaseF1*x1/xmax1;
    PhaseFDen2=PhaseF2*x2/xmax2;
    
    %Phase0 ForLoop of externally set phase 
    %Define the Phase0 setp size, then run the ForLoop
    Phase0SS=(Phase0Max-Phase0Min)/(pmax-1);
    for p=1:pmax

        Phase0(p)=Phase0Min+(p-1)*Phase0SS;
        
        PhaseDrop1=Phase0(p)+PhaseFDen1;
        PhaseDrop2=Phase0(p)+PhaseF1++PhaseFL+PhaseFDen2;
                            
        SCurrent1=SCurDen1.*(sin(PhaseDrop1)+sin(2*PhaseDrop1));
        SCurrent2=SCurDen2.*(sin(PhaseDrop2));
        
        SCurrentNet(p)=sum(SCurrent1)+sum(SCurrent2);


    end
    MaxSCurrentNet(f)=max(SCurrentNet);
    MinSCurrentNet(f)=min(SCurrentNet);
end


hold on
plot(Field,MaxSCurrentNet,'r.')
hold on 
plot(Field,MinSCurrentNet,'g.')




    




