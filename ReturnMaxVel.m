

function [maxVel,tVel]= ReturnMaxVel(filename)
% This function accepts a file and return the 
% maximum upstroke velocity
    Data = readtable(filename);
    tdata = Data.Var1; 
    Vdata = Data.Var2;
    diffV = diff(Vdata);
    diffT = diff(tdata);
    gradVel = diffV./diffT;
    maxVel =  max(gradVel); % Maximum Upstroke Velocity
    
    tVel = tdata(find(gradVel == max (gradVel))); % Time maximum Velocity occurs
    
    
    
    
end
