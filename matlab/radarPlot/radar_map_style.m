function rm = radar_map_style(s1, s2)

addr_glb = '..\..\data\global_var\';
addr = '..\..\data\results\style\';

% Indice of style s1 and s2 in F1 measure matrix
styles = load([addr_glb, 'all_styles.mat']);
styles = styles.all_styles;
idx1 = strfind(styles, s1);
idx1 = find(not(cellfun('isempty', idx1)));
idx2 = strfind(styles, s1);
idx2 = find(not(cellfun('isempty', idx2)));

% F1 measure matrix
fids = dir([addr, '*.mat']);
f1s = cell(length(fids),1);
for i = 1:length(fids)
    f1s{i} = load([addr, fids(i).name]);
    f1s{i} = f1s{i}.f1s;
end

% Features' names
ftrs = {fids.name};
for i = 1:length(ftrs)
    ftrs{i} = ftrs{i}(1:strfind(ftrs{i}, '.mat')-1);
end



end
