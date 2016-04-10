% DESCRIPTION:This file is used to extract principle components from the
% tamura feature histograms classified by styles. Then it saves the 
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
% Created: 03/31/2016; Last revision: 03/31/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\tamura\features_style\';
addr_glb = '..\..\..\data\global_var\';

styles = load([addr_glb, 'all_styles.mat']);
styles = styles.all_styles;
paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;

mkdir([addr_features,'..\pca_by_style\']);
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

                % Concatenate the tamura pixel ratios for PCA input
                tamura_hds1(m,:) = [hd_crs, hd_con, hd_dir];

                grp{m} = s1;
            end
            tmp = length(tamura_hds1);
            
            % tamura pixel ratios of the second style
            tamura_hds2 = zeros(length(fid2), 20);
            for m=1:length(fid2)
                % Load features
                load([addr_features, fid2{m}, '_tamura_hd.mat']);

                % Concatenate the tamura pixel ratios for PCA input
                tamura_hds2(m,:) = [hd_crs, hd_con, hd_dir];

                grp{m+tmp} = s2;
            end

            obs = [tamura_hds1;tamura_hds2];
            % cef(matrix): Columns represent eigenvectors
            % ltt(column vector): Eigenvalues in decreasing order
            [cef, scr, ltt] = pca(obs);

            egn = size(ltt, 1);
            % The threshhold determines the dimension of transformed dataset
            g = zeros(egn,1);
            g(1) = ltt(1);
            for k = 2:egn
                g(k) = g(k-1)+ltt(k);
            end
            L = 0;
            for L = 1:egn
                if(g(L)/g(egn) >= 0.95)
                    break;
                end
            end

            % Transform original dataset to feature space(512 dimension to L dimension)
            w = cef(:,1:L);
            fs_obs = obs * w;
            
            save([addr_features,'..\pca_by_style\',s1,'_',s2,'_pca.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------