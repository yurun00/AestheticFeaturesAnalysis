function sp = spider_style(s1, s2)

addr_glb = '..\..\data\global_var\';
addr_rst = '..\..\data\results\style\';

% Indice of style s1 and s2 in F1 measure matrix
styles = load([addr_glb, 'all_styles.mat']);
styles = styles.all_styles;
idx1 = strfind(styles, s1);
idx1 = find(not(cellfun('isempty', idx1)));
idx2 = strfind(styles, s2);
idx2 = find(not(cellfun('isempty', idx2)));

% F1 measure matrix
fids = dir([addr_rst, '*.mat']);
f1s = cell(length(fids),1);
for i = 1:length(fids)
    f1s{i} = load([addr_rst, fids(i).name]);
    f1s{i} = f1s{i}.f1s;
end

% Data of F1 measures
data = zeros(length(fids),1);
for i = 1:length(fids)
    data(i) = f1s{i}(idx1, idx2) + f1s{i}(idx2,idx1);
end

% Features' names
lbl = {fids.name};
for i = 1:length(lbl)
    lbl{i} = lbl{i}(1:strfind(lbl{i}, '_f1')-1);
end

tle = ['Classification efficiency of styles ',s1,' and ',s2];
rng = [0,1];
leg = {[s1,' and ',s2]};
% Plot the radar map
[sp, x, o] = spider(data,tle,rng,lbl,leg);

end
