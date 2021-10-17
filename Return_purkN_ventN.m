function [purKcouple,venTcouple,distCouple] = Return_purkN_ventN(pmjsFilename)
% Function written by Anthony Owusu-Mensah
% This function returns for a given purkinje node
% the myocardial nodes that are coupled to it.
% purKcouple has the Purkinje nodes
% venTcouple contains the ventricular node for a 
% corresponding Purkinje node.

data = importdata(pmjsFilename);
data = cellfun(@strsplit,data,'UniformOutput',false);
purkNodes = zeros(length(data),1);
ventNodes = zeros(length(data),1);
dist = zeros(length(data),1);
for i = 1:length(data)
    cellNum = data{i};
    purkNodes(i) = str2double(cellNum{1});
    ventNodes(i) = i;
    %dist(i) = str2double(erase(cellNum{2},'#'));
    [~,n] = size(cellNum); 
    if n > 1
        dist(i) = str2double(erase(cellNum{2},'#'));
    else
        % if second column is blank
        dist(i) = 0;
    end
end
purKcouple = purkNodes(dist~=0); % Purkinje Nodes
venTcouple = ventNodes(dist~=0); % Myocardial Nodes coupled to purkinje
distCouple = dist(dist~=0); % The coupling distance btwn purkinje and vent myocytes
end
