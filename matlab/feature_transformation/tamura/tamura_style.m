% DESCRIPTION:The extracted tamura feature histograms will be classified by
% styles. Then it saves the observations and the groups to '.mat' files for
% clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\all_styles.mat
%   ..\..\..\data\features\tamura\features_style\_tamura_hd.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\tamura\features_style\';
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
            
            % Tamura feature histograms of the first style
            tamura_hds1 = zeros(length(fid1), 20);
            for m=1:length(fid1)
                % Load features
                load([addr_features, fid1{m}, '_tamura_hd.mat']);

                % Concatenate the tamura feature histograms for PCA input
                tamura_hds1(m,:) = [hd_crs, hd_con, hd_dir];

                grp{m} = s1;
            end
            tmp = length(tamura_hds1);
            
            % Tamura feature histograms of the second style
            tamura_hds2 = zeros(length(fid2), 20);
            for m=1:length(fid2)
                % Load features
                load([addr_features, fid2{m}, '_tamura_hd.mat']);

                % Concatenate the tamura feature histograms for PCA input
                tamura_hds2(m,:) = [hd_crs, hd_con, hd_dir];

                grp{m+tmp} = s2;
            end

            fs_obs = [tamura_hds1;tamura_hds2];
            
            save([addr_features,'..\obs_grp_style\',s1,'_',s2,'_obs_grp.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------