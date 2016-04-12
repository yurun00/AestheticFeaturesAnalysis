% DESCRIPTION:This file is used to extract the straight line features with 
% corresponding style labels classified by styles. Then it saves the 
% transformed observations in feature space to '.mat' files for clustering 
% analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu, undergraduate, computer science
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn
% Website: none
% Created: 04/10/2016; Last revision: 04/12/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\line\features_style\';
addr_glb = '..\..\..\data\global_var\';

styles = load([addr_glb, 'all_styles.mat']);
styles = styles.all_styles;
paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;

mkdir([addr_features,'..\obs_grp_style\']);
for i = 1:length(styles)
    for j = 1:length(styles)
        if(i < j)
            s1 = styles{i};
            s2 = styles{j};
            fid1 = paintings_by_style(s1);
            fid2 = paintings_by_style(s2);
            
            % Store the categories of the corresponding paintings
            grp = cell(length(fid1) + length(fid2), 1);
            
            % Straight line features of the first style
            lines1 = zeros(length(fid1), 5);
            for m=1:length(fid1)
                % Load features
                load([addr_features, fid1{m}, '_lines.mat']);

                % Concatenate the straight line features for PCA input
                lines1(m,:) = lines;

                grp{m} = s1;
            end
            tmp = length(lines1);
            
            % Straight line features of the second style
            lines2 = zeros(length(fid2), 5);
            for m=1:length(fid2)
                % Load features
                load([addr_features, fid2{m}, '_lines.mat']);

                % Concatenate the straight line features for PCA input
                lines2(m,:) = lines;

                grp{m+tmp} = s2;
            end

            fs_obs = [lines1;lines2];
            
            save([addr_features,'..\obs_grp_style\',s1,'_',s2,'_obs_grp.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------