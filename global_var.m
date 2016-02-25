% Description: This file is used to extract some global variables.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Run Yu
% Nanjing University, Dept. of Computer S&T
% Email address: 121220127@smail.nju.edu.cn 
% Created: 02/25/2016; Last revision: 02/25/2016

%------------- BEGIN CODE --------------

addr = '.\data\paintings_classified\genre\'; 
addr_sv = '.\data\global_var\';
genres = dir(addr);
genres = {genres(3:end).name};
save([addr_sv, 'genres.mat'], 'genres');

%------------- END OF CODE --------------