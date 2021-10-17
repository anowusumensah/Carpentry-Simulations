% Visualize last 2 action action potentials
% 1. Read files
% 2. Get columns for time & Voltage
% 3. Plot to see action potential

close all; clear; clc; 
myPlot('Steward_control.txt.txt','Steward_g_Kr50.txt.txt','Steward_g_Kr75.txt.txt',...
    'Steward_g_Kr0.txt.txt')
%myPlot('Steward_g_Kr50.txt.txt')
xlabel('Time (ms)')
ylabel('V (mV)')
title('Steward model')
legend('control','50% block IKr','75% block IKr','100% block IKr','Location','best')
%legend('control','Isoproterenol','Location','best')
set(gca,'FontSize',20)


function myPlot(varargin)
    figure('Color',[1 1 1]);
    colors = colormap(hsv(4));
   
    switch nargin
        case 1
            [tPlot, vPlot] = Read_Last2APD_data(varargin{1});
            plot(tPlot,vPlot,'Color',colors(1,:),'LineWidth',1.5);
            %tPlot(1)
        case 2
            for i = 1:2
                [tPlot, vPlot] = Read_Last2APD_data(varargin{i});
                plot(tPlot,vPlot,'Color',colors(i,:),'LineWidth',1.5);hold on
                tmin(i) = min(tPlot); tmax(i) = max(tPlot); 
            end
            xlim([min(tmin),max(tmax)]);
            hold off
               
        case 3
           for i = 1:3
               [tPlot, vPlot] = Read_Last2APD_data(varargin{i});
                plot(tPlot,vPlot,'Color',colors(i,:),'LineWidth',1.5);hold on
                tmin(i) = min(tPlot); tmax(i) = max(tPlot); 
            end
            xlim([min(tmin),max(tmax)]);
            hold off

               
          case 4
           for i = 1:4
               [tPlot, vPlot] = Read_Last2APD_data(varargin{i});
                plot(tPlot,vPlot,'Color',colors(i,:),'LineWidth',1.5);hold on
                tmin(i) = min(tPlot); tmax(i) = max(tPlot); 
            end
            xlim([min(tmin),max(tmax)]);
            hold off
           
        otherwise
            disp('Input more than 4')
    end
    
    
end