% DESCRIPTION:This file is used to extract principle components from the
% color temperature and weight features classified by styles. Then it saves 
% the transformed observations in feature space to '.mat' files for 
% clustering analysis.
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

addr_features = '..\..\..\data\features\color_tmp_wt\features_style\';
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
            colors1 = zeros(length(fid1), 10);
            for m=1:length(fid1)
                % Load features
                load([addr_features, fid1{m}, '_color_tmp_wt.mat']);

                % Concatenate the tamura pixel ratios for PCA input
                colors1(m,:) = [tmp', wt'];
                if(tmp(1) == 'NaN')
                    disp(m);
                end
                grp{m} = s1;
            end
            t = length(colors1);
            
            % tamura pixel ratios of the second style
            colors2 = zeros(length(fid2), 10);
            for m=1:length(fid2)
                % Load features
                load([addr_features, fid2{m}, '_color_tmp_wt.mat']);

                % Concatenate the tamura pixel ratios for PCA input
                colors2(m,:) = [tmp', wt'];

                grp{m+t} = s2;
            end

            obs = [colors1;colors2];
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