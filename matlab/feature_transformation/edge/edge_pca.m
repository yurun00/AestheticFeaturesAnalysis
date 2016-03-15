% DESCRIPTION:This file is used to extract principle components from the
% rgb histograms classified by genres. Then it saves the transformed
% observations in feature space to '.mat' files for clustering analysis.
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
% Created: 01/28/2016; Last revision: 02/27/2016

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\edge\all_features\';
addr_glb = '..\..\..\data\global_var\';
styles = load([addr_glb, 'all_styles.mat']);
styles = styles.all_styles;

paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;

for i = 1:length(style)
    for j = 1:length(styles)
        if(i < j)
            s1 = styles{i};
            s2 = styles{j};
            fid1 = paintings_by_style(s1);
            fid2 = paintings_by_style(s2);
            
            % Store the categories of the corresponding paintings
            grp = cell(length(fid1) + length(fid2), 1);
            addi = 0;
            
            % Edge pixel ratios of the first style
            edges1 = zeros(length(fid1), 4);
            for m=1:length(fid1)
                % Load features
                edge = load([addr_features, fid1(m), '_edge_ratio.mat']);
                edge = edge.ratios;

                % Concatenate the edge pixel ratios for PCA input
                edges1(m,:) = edge';

                grp{m} = s1;
            end
            tmp = length(edges1);
            
            % Edge pixel ratios of the second style
            edges2 = zeros(length(fid2), 4);
            for m=1:length(fid2)
                % Load features
                edge = load([addr_features, fid2(m), '_edge_ratio.mat']);
                edge = edge.ratios;

                % Concatenate the edge pixel ratios for PCA input
                edges2(m,:) = edge';

                grp{m+tmp} = s2;
            end

            obs = [edges1;edges2];
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
            obs = obs * w;
            
            save([addr_features,'..\pca_by_style\',s1,'_',s2,'_pca.mat'],'obs','grp');
        end
    end
end

%------------- END OF CODE --------------