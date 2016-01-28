%Description: This file is used to transform '.jpg' files to '.mat' files
%in a certain directory. The 'All_oil_paintings\' does not exist for now.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 01/22/2016; Last revision: 01/22/2016

%------------- BEGIN CODE --------------

img_file_path = 'All_oil_paintings\'; 
img_path_list = dir(strcat(img_file_path,'*.jpg'));	
img_num = length(img_path_list);

if img_num > 0
        for j = 1:img_num
            img_name = img_path_list(j).name;
            img = imread(strcat(img_file_path,img_name));  
            %show the name on console screen
            fprintf('%d %s\n',j,strcat(img_file_path,img_name));
            name_len = strfind(img_name,'.jpg')-1;
            %save the file
            save(strcat('All_oil_paintings\',img_name(1:name_len),'.mat'),'img'); %'All_paintings_mat' for now
        end  
end  

%------------- END OF CODE --------------