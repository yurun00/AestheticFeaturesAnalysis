addr_features = '..\..\..\data\features\hsv_hist\features_style\';
addr_pca = '..\..\..\data\features\hsv_hist\pca_by_style\';
addr_glb = '..\..\..\data\global_var\';
paintings_by_style = load([addr_glb, 'paintings_by_style.mat']);
paintings_by_style = paintings_by_style.paintings_by_style;
s1 = 'Expressionism';
s2 = 'Pointillism';
L1 = length(paintings_by_style(s1));
L2 = length(paintings_by_style(s2));

fid1 = paintings_by_style(s1);
fid2 = paintings_by_style(s2);
hsvhds1 = zeros(length(fid1), 24);
for m=1:length(fid1)
    hsvhd = load([addr_features, fid1{m}, '_hsv_hist24d.mat']);
    hsvhd = hsvhd.hsv_hist;
    hsvhds1(m,:) = hsvhd(:)';
end
hsvhds2 = zeros(length(fid2), 24);
for m=1:length(fid2)
    hsvhd = load([addr_features, fid2{m}, '_hsv_hist24d.mat']);
    hsvhd = hsvhd.hsv_hist;
    hsvhds2(m,:) = hsvhd(:)';
end
obs = [hsvhds1;hsvhds2];

fs_grp_in = load([addr_pca,s1,'_',s2,'_pca.mat']);
fs_obs_in = fs_grp_in.fs_obs;
grp_in = fs_grp_in.grp;

s = ones(length(grp_in),1)*10;
c = [repmat([1,0,0],L1,1);repmat([0,1,0],L2,1)];
% scatter(fs_obs_in(:,1),fs_obs_in(:,2),s,c);
scatter3(fs_obs_in(:,1),fs_obs_in(:,2),fs_obs_in(:,3),s,c);
rotate3d on;
% scatter3(obs(:,1),obs(:,2),obs(:,3),s,c);
