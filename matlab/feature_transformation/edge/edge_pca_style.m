% DESCRIPTION:The extracted principle components from the edge pixel 
% features will be classified by styles. Then it saves the transformed
% observations in feature space to '.mat' files for clustering analysis.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: ..\..\..\data\global_var\all_styles.mat
%   ..\..\..\data\features\edge\features_style\*_edge_ratio.mat
%
% See also: none

%------------- BEGIN CODE --------------

clear; clc;

addr_features = '..\..\..\data\features\edge\features_style\';
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
            
            % Edge pixel ratios of the first style
            edges1 = zeros(length(fid1), 4);
            for m=1:length(fid1)
                % Load features
                edge = load([addr_features, fid1{m}, '_edge_ratio.mat']);
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
                edge = load([addr_features, fid2{m}, '_edge_ratio.mat']);
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

            % Transform original dataset to feature space
            w = cef(:,1:L);
            fs_obs = obs * w;
            
            save([addr_features,'..\pca_by_style\',s1,'_',s2,'_pca.mat'],'fs_obs','grp');
        end
    end
end

%------------- END OF CODE --------------