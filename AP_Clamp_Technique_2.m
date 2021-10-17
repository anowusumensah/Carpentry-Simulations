
close all; clear; clc;

%Data Preparation -------------------------------------------------
Data = readtable('ARPF_bcl_500_control.txt');
tdata = Data.Var1; 
Vdata = Data.Var2;
R = 8.314; %J K^-1 mol^-1
T = 310; %K
F = 96.4867; %C.mmol^-1
K_o = 5.4; %mM
K_i = 135; %mM
EK =((R*T)/F)*log10(K_o/K_i);
GIKr = 0.03*((K_o/5.4)^0.5);
%GIKr = 0.03*sqrt(K_o/5.4);

%plot(tdata,Vdata )
vClamp  = Vdata(49400:50000);
tp = tdata(49400:50000);
Xr = zeros(length(vClamp),1);
Xr(1) =  8.39798303061036e-05;
%%Xr(1) =  8.4219e-05;
dt = 1e-9;
%dt = tp(2)-tp(1);
V = vClamp;
tStart = 0;
t = zeros(length(vClamp),1);
tcount = 0;
%% Formulars
for i = 1:length(vClamp) - 1
% %     Xss = 1/(1 + exp(-(V(i)+ 50)/ 7.5));
% %     Rr(i) = 1./ (1 + exp((V(i) + 33)/22.4));
% %     alpha = 0.00138*(V(i) + 7)/(1-exp(-0.123*(V(i) + 7)));
% %     beta= 0.00061*(V(i) + 10)/(exp(0.145*(V(i) + 10)) - 1);
% %     tauXr = 1/ (alpha + beta);
% %     Xr(i+1) = Xr(i)+ dt* ((Xss - Xr(i))./tauXr);
% %     tcount = tStart + i*dt;
% %     t(i+1) = tcount;
    
    Xss = 1/(1 + exp(-(V(i)+ 50-35)/ 7.5));
    Rr(i) = 1./ (1 + 6*exp(0.05*V(i)));
    alpha = (1 - exp(-0.123*(V(i)+ 7-35)))/(0.00138*(V(i) + 7-35));
    beta= 0.00061*(V(i) + 10-35)/(exp(0.145*(V(i) + 10-35)) - 1);
    tauXr = alpha + beta;
    Xr(i+1) = Xr(i)+ dt* ((Xss - Xr(i))./tauXr);
    tcount = tStart + i*dt;
    t(i+1) = tcount;
end
% Rrs = 1./ (1 + exp((V + 33)/22.4));
%Rrs = Rrs';
Rrs = 1./ (1 + 6*exp(0.05*V));
figure;
plot(t,Xr); xlabel('Time (ms)'); ylabel('Activation')
figure;
plot(t,vClamp,'r','LineWidth',1.5); xlabel('Time (ms)'); ylabel('V (ms)');
xlim([min(t) max(t)]);
% % 
figure;
IKr = GIKr.* Xr.*Rrs.*(V - EK);
plot(t,IKr,'LineWidth',1.5); hold on; plot(t,0.5*IKr,'LineWidth',1.5); 
xlim([min(t) max(t)]);

xlabel('Time (ms)'); ylabel('IKr')
legend('100% IKr','50% IKr')


Xr(end)
Xss