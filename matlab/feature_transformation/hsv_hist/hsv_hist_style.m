% DESCRIPTION:The extracted HSV histogram 
% features will be classified by styles. Then it saves the transformed 
% observations in feature space to '.mat' files for clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\all_styles.mat
%   ..\..\..\data\features\hsv_hist\features_style\*_hsv_hist24d.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\hsv_hist\features_style\';
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
            
            % HSV histograms of the first style
            hsvhds1 = zeros(length(fid1), 24);
            for m=1:length(fid1)
                % Load features
                hsvhd = load([addr_features, fid1{m}, '_hsv_hist24d.mat']);
                hsvhd = hsvhd.hsv_hist;

                % Concatenate the HSV histograms for PCA input
                hsvhds1(m,:) = hsvhd(:)';

                grp{m} = s1;
            end
            tmp = length(hsvhds1);
            
            % HSV histograms of the second style
            hsvhds2 = zeros(length(fid2), 24);
            for m=1:length(fid2)
                % Load features
                hsvhd = load([addr_features, fid2{m}, '_hsv_hist24d.mat']);
                hsvhd = hsvhd.hsv_hist;

                % Concatenate the HSV histograms for PCA input
                hsvhds2(m,:) = hsvhd(:)';

                grp{m+tmp} = s2;
            end

            fs_obs = [hsvhds1;hsvhds2];
            
            save([addr_features,'..\obs_grp_style\',s1,'_',s2,'_obs_grp.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------