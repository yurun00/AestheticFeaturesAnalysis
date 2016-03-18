%Description: This file is used to transform '.jpg' files to '.mat' files
%in a certain directory. 
%
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
[~,~,raw] = xlsread([addr, 'paintings.xlsx']);
num = length(raw);


if num > 0
        for j = 1:num
            img_name = raw{j};
            img = imread([addr,'oil_used\',img_name]);  
            %show the name on console screen
            fprintf('%d %s\n',j,img_name);
            img_name = img_name(1:strfind(img_name,'.jpg')-1);
            %save the file
%             save(['..\data\paintings_mat\',img_name,'.mat'],'img'); 
            save(['..\data\tmp\',img_name,'.mat'],'img'); 
        end  
end  

%------------- END OF CODE --------------