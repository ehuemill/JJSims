

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


%For Version 2, a geometrical loop was added so that the supercurrent vs
%field plot could include different amounts of phase shift for a determined
%portion of the junction.


%%

clear;
clc;
close all;
%% Defining the Parameters of the Simulaiton

%Initial COnditions of the Simmulation
    xmax=51;
    x(:,1)=(1:xmax);

    SCurrentMag=1;
    SCurNoiseMag=0.001;



%Setting Loop Parameters

    %Phase Loop parameters
    p=1;
    pmax=101;
    Phase1Min=0*pi;
    Phase1Max=2*pi;


    %Flux Loop Parameters
    f=1;
    fmax=2001;
    FluxinJuncMin=-5;
    FluxinJuncMax=5;


    %geometrical/Intrinsic Phase Loop Parameters
    g=1;
    gmax=4;
    PhaseGMin=-.5*pi;
    PhaseGMax=pi;

    
%Calculating Parameters from Initial Conditions
	SCurrentDensityNoise=SCurNoiseMag*(2*rand(xmax,1)-1);
    SCurrentDensity=SCurrentMag*ones(xmax,1)+exp(SCurrentDensityNoise);
    
    
       
%Pre Allocating memory to the arrays to decrease runtime
    Phase1=zeros(1,pmax);
    PhaseG=zeros(xmax,1);
    PhaseGShift=zeros(1,gmax);
    FluxinJunc=zeros(1,fmax);

    SCurrent=zeros(xmax,pmax,fmax);
    SCurrentNet=zeros(1,pmax);
    MaxSCurrentNet=zeros(fmax,gmax);


%% Loops for running the simulation (Meat of the Simulation)

%Geometrical factor Loop
%Define the loop setp size, then run the for loop
PhaseGSS=(PhaseGMax-PhaseGMin)/(gmax-1);
for g=1:gmax
    PhaseGShift(g)=PhaseGMin+(g-1)*PhaseGSS;
    
    %Defining the geometrical(intrinsic) phase shift in the junction
    PhaseG(1:round(xmax/2),1)=0;
    PhaseG(1:xmax-round(xmax/2),1)=PhaseGShift(g);
    
    
    %Field Contribution to the Phase 
    %Define the loop setp size, then run the for loop
    FluxinJuncSS=(FluxinJuncMax-FluxinJuncMin)/(fmax-1);
    for f=1:fmax

        FluxinJunc(f)=FluxinJuncMin+(f-1)*FluxinJuncSS;
        PhaseF=2*pi*x./xmax*FluxinJunc(f);
        
        %Phase1 Loop of externally set phase in 
        %Define the loop setp size, then run the for loop
        Phase1SSS=(Phase1Max-Phase1Min)/(pmax-1);
        for p=1:pmax

            Phase1(p)=Phase1Min+(p-1)*Phase1SSS;

            SCurrent=SCurrentDensity.*sin(PhaseF+Phase1(p)+PhaseG);
            SCurrentNet(p)=sum(SCurrent)/xmax;


        end

        MaxSCurrentNet(f,g)=max(SCurrentNet);

    end

end

figure
plot(FluxinJunc,MaxSCurrentNet,'.')
xlabel('Flux in Junction');ylabel('Net Supercurrent');





    




