% DESCRIPTION:The extracted the color temperature and weight features will 
% be classified by styles. Then it saves the observations and groups to 
% '.mat' files for clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\all_styles.mat
%   ..\..\..\data\global_var\paintings_by_style.mat
%   ..\..\..\data\features\color_tmp_wt\features_style\*_color_tmp_wt.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\color_tw\features_style\';
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
            
            % Color features of the first style
            colors1 = zeros(length(fid1), 18);
            for m=1:length(fid1)
                % Load features
                load([addr_features, fid1{m}, '_color_tw.mat']);

                % Concatenate the color features for PCA input
                colors1(m,:) = [gbcolor, lccolor];
                grp{m} = s1;
            end
            t = length(colors1);
            
            % Color features of the second style
            colors2 = zeros(length(fid2), 18);
            for m=1:length(fid2)
                % Load features
                load([addr_features, fid2{m}, '_color_tw.mat']);

                % Concatenate the color features for PCA input
                colors2(m,:) = [gbcolor, lccolor];

                grp{m+t} = s2;
            end

            fs_obs = [colors1;colors2];
            
            save([addr_features,'..\obs_grp_style\',s1,'_',s2,'_obs_grp.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------