addr_features = '..\..\..\data\features\tamura\features_style\';
addr_pca = '..\..\..\data\features\tamura\pca_by_style\';
addr_glb = '..\..\..\data\global_var\';
paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
s1 = 'Impressionism';
s2 = 'Realism';
L1 = length(paintings_by_style(s1));
L2 = length(paintings_by_style(s2));

% fid1 = paintings_by_style(s1);
% fid2 = paintings_by_style(s2);
% tamuras1 = zeros(length(fid1), 4);
% for m=1:length(fid1)
%     load([addr_features, fid1{m}, 'tamura_hd.mat']);
%     tamuras1(m,:) = [hd_crs,hd_con,hd_dir];
% end
% tamuras2 = zeros(length(fid2), 4);
% for m=1:length(fid2)
%     load([addr_features, fid2{m}, '_tamura_hd.mat']);
%     tamuras2(m,:) = [hd_crs,hd_con,hd_dir];
% end
% obs = [tamuras1;tamuras2];

fs_grp_in = load([addr_pca,s1,'_',s2,'_pca.mat']);
fs_obs_in = fs_grp_in.fs_obs;
grp_in = fs_grp_in.grp;

s = ones(length(grp_in),1)*10;
c = [repmat([1,0,0],L1,1);repmat([0,1,0],L2,1)];
% scatter(fs_obs_in(:,1),fs_obs_in(:,2),s,c);
scatter3(fs_obs_in(:,1),fs_obs_in(:,2),fs_obs_in(:,3),s,c);
% scatter3(obs(:,1),obs(:,2),obs(:,3),s,c);
rotate3d on;
