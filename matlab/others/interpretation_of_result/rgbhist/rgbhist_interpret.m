addr_genre = '..\..\..\data\features\rgb_hist\genre\';
sfs_mce_fs = load([addr_genre,'_fs_sel\landscape_portrait_sfs_mce_fs.mat']);
fs = sfs_mce_fs.features;
norm_rgbhist = zeros(512,1);
[~,sz] = size(fs);
norm_rgbhist(fs) = (0.02-0.018/sz):-(0.018/sz):0.002;
scatter3_rgb(norm_rgbhist);