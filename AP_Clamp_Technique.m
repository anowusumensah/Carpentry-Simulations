
close all; clear; clc;

%Purkinje Data Preparation -------------------------------------------------
Data = readtable('ARPF_bcl_500_control.txt');
tdata = Data.Var1; 
Vdata = Data.Var2;
vClamp  = Vdata(49400:50000);
tp = tdata(49400:50000);
Xr = zeros(length(vClamp),1);
Xr(1) =   0.0089;
%%Xr(1) =  8.4219e-05;
dt = 1;
%dt = tp(2)-tp(1);
V = vClamp;
tStart = 0;
t = zeros(length(vClamp),1);
tcount = 0;
%% ========================================================================================================
%%=========================================================================================================
%Ventricular Data Preparation -------------------------------------------------
DataV = readtable('UCLA_RAB_bcl_500_control.txt');
tdataV = DataV.Var1; 
VdataV = DataV.Var2;
vClampV  = VdataV(49400:50000);
tpV = tdataV(49400:50000);
XrV = zeros(length(vClampV),1);
XrV(1) = 0.0066;
dtV = 1;
vV = vClampV; 
tStartV = 0;

%%====================================================================================================
%% Common Parameters
%% ====================================================================================================

R = 8.314; %J K^-1 mol^-1
T = 310; %K
F = 96.4867; %C.mmol^-1
K_o = 5.4; %mM
K_i = 135; %mM
EK =((R*T)/F)*log10(K_o/K_i);
GIKr = 0.03*((K_o/5.4)^0.5);
%GIKr = 0.03*sqrt(K_o/5.4);

%PurKinje Data

%% Purk Loop
for i = 1:length(vClamp) - 1
    Xss = 1/(1 + exp(-(V(i)+ 50)/ 7.5));
    Rr(i) = 1./ (1 + exp((V(i) + 33)/22.4)); % Inactivation Parameter
    alpha = 0.00138*(V(i) + 7)/(1-exp(-0.123*(V(i) + 7)));
    beta= 0.00061*(V(i) + 10)/(exp(0.145*(V(i) + 10)) - 1);
    tauXr = 1/ (alpha + beta);
    Xr(i+1) = Xr(i)+ dt* ((Xss - Xr(i))./tauXr); % Activation Parameter
    tcount = tStart + i*dt;
    t(i+1) = tcount;
    
% %     Xss = 1/(1 + exp(-(V(i)+ 50-35)/ 7.5));
% %     Rr(i) = 1./ (1 + 6*exp(0.05*V(i)));
% %     alpha = (1 - exp(-0.123*(V(i)+ 7-35)))/(0.00138*(V(i) + 7-35));
% %     beta= 0.00061*(V(i) + 10-35)/(exp(0.145*(V(i) + 10-35)) - 1);
% %     tauXr = alpha + beta;
% %     Xr(i+1) = Xr(i)+ dt* ((Xss - Xr(i))./tauXr);
% %     tcount = tStart + i*dt;
% %     t(i+1) = tcount;
end

%% Ventricular Loop
for j = 1:length(vClampV) - 1
    XssV = 1/(1 + exp(-(vV(j)+ 50)/ 7.5));
    RrV(j) = 1./ (1 + exp((vV(j) + 33)/22.4)); % Inactivation Parameter
    alpha = 0.00138*(vV(j) + 7)/(1-exp(-0.123*(vV(j) + 7)));
    beta= 0.00061*(vV(j) + 10)/(exp(0.145*(vV(j) + 10)) - 1);
    tauXrV = 1/ (alpha + beta);
    XrV(j+1) = XrV(j)+ dtV* ((XssV - XrV(j))./tauXrV); % Activation Parameter
    tcountV = tStartV + j*dtV;
    tV(j+1) = tcountV;
end
Rrs = 1./ (1 + exp((V + 33)/22.4));
RrsV = 1./ (1 + exp((vV + 33)/22.4));
IKr = GIKr.* Xr.*Rrs.*(V - EK); % Purkinje IKr
IKrV = GIKr.* XrV.*RrsV.*(vV - EK); % Ventricular IKr

%% 
figure('Color',[1 1 1]);
plot(t,vClamp,'LineWidth',1.5); hold on;
plot(tV,vClampV,'LineWidth',1.5);
xlabel('Time (ms)'); ylabel('V (ms)');
legend('PurK AP','Vent AP')
xlim([min(t) max(t)]);

%%
figure('Color',[1 1 1]);
plot(t,IKr,'LineWidth',1.5); hold on; 
plot(tV,IKrV,'LineWidth',1.5); 
xlabel('Time (ms)'); ylabel('IKr')
legend('Purk','Vent')
xlim([min(t) max(t)]);

%%
% % figure('Color',[1 1 1]);
% % plot(t,Xr,'LineWidth',1.5); hold on;
% % plot(tV,XrV,'LineWidth',1.5);
% % xlabel('Time (ms)'); ylabel('Activation parameter');
% % legend('PurK','Vent')
% % xlim([min(t) max(t)]);


