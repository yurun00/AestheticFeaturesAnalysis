clear; clc;

addr_glb = '..\..\data\global_var\';
addr_pca = '..\..\data\features\edge\pca_by_style\';
addr_rst = '..\..\data\results\';

styles = load([addr_glb, 'all_styles.mat']);
styles = styles.all_styles;

f1s = load([addr_rst, 'style\edge_f1_measure.mat']);
f1s = f1s.f1s;

bar3(f1s);
rotate3d on;
set(gca,'xtick',1:8,'xticklabel',styles);
set(gca,'ytick',1:8,'yticklabel',styles);
