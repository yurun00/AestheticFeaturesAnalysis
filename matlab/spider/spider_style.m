function sp = spider_style(sts)

% sp = spider_style('Cubism');
% sp = spider_style({'Cubism' 'Expressionism' 'Fauvism'});
% sp = spider_style({'Cubism' 'Expressionism';'Cubism' 'Fauvism'});

addr_glb = '..\..\data\global_var\';
addr_rst = '..\..\data\results\style\';

% Indice of style s1 and s2 in F1 measure matrix
styles = load([addr_glb, 'all_styles.mat']);
styles = styles.all_styles;
fids = dir([addr_rst, '*.mat']);

% F1 measure matrice and Features' names
f1ms = cell(length(fids),1);
lbl = {fids.name};
for j = 1:length(fids)
    load([addr_rst, fids(j).name]);
    f1ms{j} = f1s;
    lbl{j} = lbl{j}(1:strfind(lbl{j}, '_f1')-1);
end

% Spider plot title
tle = 'Spider map of classification efficiency';

% Peak range of the data (Mx1 or Mx2)
rng = [0,1];

% Data set legend identification (1xN)
leg = {};

if nargin < 2 
    if ischar(sts)
        % Input data (MxN) (# data sets (M) x # axes (N))
        data = zeros(length(fids),length(styles)-1);
        
        s1 = sts;
        idx1 = strfind(styles, s1);
        idx1 = find(not(cellfun('isempty', idx1)));
        k = 1;
        for i = 1:length(styles)
            if(i ~= idx1)
                s2 = styles{i};
                idx2 = strfind(styles, s2);
                idx2 = find(not(cellfun('isempty', idx2)));
                 % Data of F1 measures
                for j = 1:length(fids)
                    data(j,k) = f1ms{j}(idx1, idx2) + f1ms{j}(idx2,idx1);
                end
                leg = [leg, [s1,' and ',s2]];
                k = k+1;
            end
        end
        % Plot the radar map
        [sp, x, o] = spider(data,tle,rng,lbl,leg);
        set(sp, 'Position', [400,200,600,400]);
        return;
    elseif iscell(sts) && size(sts,1) == 1 && size(sts,2) > 2
        % Input data (MxN) (# data sets (M) x # axes (N))
        data = zeros(length(fids),(length(sts)-1)*length(sts)/2);
        for i = 1:length(sts)
            tmp = strfind(styles, sts{i});
            idx(i) = find(not(cellfun('isempty', tmp)));
        end
        t = 1;
        for i = 1:length(idx)
            for j = 1:length(idx)
                if(i < j)
                    % Data of F1 measures
                    for k = 1:length(fids)
                        data(k,t) = f1ms{k}(i, j) + f1ms{k}(j, i);
                    end
                    t = t+1;
                    leg = [leg, [styles{i},' and ',styles{j}]];
                end
            end
        end
         % Plot the radar map
        [sp, x, o] = spider(data,tle,rng,lbl,leg);
        set(sp, 'Position', [400,200,600,400]);
        return;
    elseif iscell(sts) && size(sts,2) == 2
        sz = size(sts);
        % Input data (MxN) (# data sets (M) x # axes (N))
        data = zeros(length(fids),sz(1));
        for i = 1:sz(1)
            s1 = sts{i,1};
            s2 = sts{i,2};
            idx1 = strfind(styles, s1);
            idx1 = find(not(cellfun('isempty', idx1)));
            idx2 = strfind(styles, s2);
            idx2 = find(not(cellfun('isempty', idx2)));
            
            % Data of F1 measures
            for j = 1:length(fids)
                data(j,i) = f1ms{j}(idx1, idx2) + f1ms{j}(idx2, idx1);
            end
            leg = [leg, [s1,' and ',s2]];
        end
        % Plot the radar map
        [sp, x, o] = spider(data,tle,rng,lbl,leg);
        set(sp, 'Position', [400,200,600,400]);
        return;
    else ;
    end
end

end
