close all; clear; clc;

fileID = fopen('TBunnyC.elem');
readstartrow= 1;
% format='%5s%5s%5s%5.0f%8.3f%8.3f%8.3f%8.4f%8.4f%8.4f%[^\n\r]';
format='%2s%6d%6d%6d%6d%4d%*[^\n\r]';
Line2 = {fgets(fileID)};
nAtoms=str2double(Line2);
%AllTraj=textscan(fileID,format,'HeaderLines',readstartrow);
AllTraj=textscan(fileID, format, nAtoms, 'Delimiter', '', 'WhiteSpace', '', 'EmptyValue' ,NaN,'HeaderLines', readstartrow, 'ReturnOnError', false);
fclose(fileID);
%%

%% Regions
regions = AllTraj(:,end);
regions = regions{:};
uniqRegions = unique(regions)




