function output = cpr_1(PhaseDrop1,Alpha)
%The goal of this is to make a concise method for adjusting the cpr of 
%the junction to be whatever we want it to be without needing to go all 
%the way into the program to adjust it.  

%input: vector of phase differences

%output: vector of supercurrents according to the given CPR

CPR_Width = .1;
cpr_envelope = 1*exp(-((PhaseDrop1-pi)/CPR_Width).^2)-1*exp(-((PhaseDrop1-3.*pi)/CPR_Width).^2);

output = (1-Alpha).*sin(PhaseDrop1)+Alpha.*1.*cpr_envelope.*sin(PhaseDrop1/2);

end