function [maxVel,tVel]= ReturnMaxVel(filename)
% Function written by Anthony Owusu-Mensah
% This function accepts an action potential file and return the 
% maximum upstroke velocity and the time it occurs
    Data = readtable(filename);
    tdata = Data.Var1; 
    Vdata = Data.Var2;
    diffV = diff(Vdata);
    diffT = diff(tdata);
    gradVel = diffV./diffT;
    maxVel =  max(gradVel); % Maximum Upstroke Velocity
    tVel = tdata(find(gradVel == max (gradVel))); % Time maximum Velocity occurs 
    
end
