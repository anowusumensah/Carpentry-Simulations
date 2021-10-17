
function [varargout]= CalculateAPDfromStats(varargin)
% eg
%[APD_control,APD_gkr50,APD_gkr75] = CalculateAPDfromStats(filename1,filename2,filename3)

    switch nargin
        case 1
            dataStruct  = importdata(varargin{1});
            dataAct = dataStruct.data;
            APD_data = dataAct(:,2);
            APD_dur = mean(APD_data(length(APD_data)- 11: end));
            varargout{1} =  APD_dur; 
        case 2
            for i = 1:2
                dataStruct  = importdata(varargin{i});
                dataAct = dataStruct.data;
                APD_data = dataAct(:,2);
               APD_dur = mean(APD_data(length(APD_data)- 11: end));
                varargout{i} =  APD_dur; 
            end
        case 3
            for i = 1:3
                dataStruct  = importdata(varargin{i});
                dataAct = dataStruct.data;
                APD_data = dataAct(:,2);
                APD_dur = mean(APD_data(length(APD_data)- 11: end));
                varargout{i} =  APD_dur; 
            end
        case 4
            for i = 1:4
                dataStruct  = importdata(varargin{i});
                dataAct = dataStruct.data;
                APD_data = dataAct(:,2);
                APD_dur = mean(APD_data(length(APD_data)- 11: end));
                varargout{i} =  APD_dur; 
            end
            
        otherwise
            disp('Input more than 4')
    end
  
   
end

