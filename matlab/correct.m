% Description: This file is used to correct the file list in 
% 'wikipaintings.xlsx', 'wikipaintings_genre.xlsx' and 
% 'wikipaintings_style.xlsx' for that some paintings in 
% 'wikipaintings.xlsx' do not exist in the folder 'oil_used'.
% These mistakes must be corrected and the new files are saved as 
% 'paintings.xlsx', 'paintings_genre.xlsx' and 'paintings_style.xlsx'. 
%
% In this script, 'oil_used.xlsx' is the files' names in the folder 
% 'oil_used'.

% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 01/22/2016; Last revision: 03/17/2016

%------------- BEGIN CODE --------------

clear;clc;
addr = '..\data\'; 
[~,~,ou] = xlsread([addr, 'oil_used.xlsx']);
[~,~,wkpt_g] = xlsread([addr, 'wikipaintings_genre.xlsx']);
[~,~,wkpt_s] = xlsread([addr, 'wikipaintings_style.xlsx']);
pt_g = ismember(wkpt_g(:,2),ou);
pt = wkpt_g(pt_g,2);
pt_g = wkpt_g(pt_g,:);
pt_s = ismember(wkpt_s(:,2),ou);
pt_s = wkpt_s(pt_s,:);
xlswrite([addr,'paintings.xlsx'],pt);
xlswrite([addr,'paintings_genre.xlsx'],pt_g);
xlswrite([addr,'paintings_style.xlsx'],pt_s);

%------------- END OF CODE --------------