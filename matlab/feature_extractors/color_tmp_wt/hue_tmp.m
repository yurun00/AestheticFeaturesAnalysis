function hts = hue_tmp( hue )
% hue_tmp - Extract the hue temperature feature from hue components of the 
% image in LCH colorspace.
%
% Syntax: TMP = COL_WT( H);
%
% Inputs:
%   hue     - Hue value of the pixel in a LCH colorspace image.
%
% Outputs:
%   hts     - The hue temperature of the hue value.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

%------------- BEGIN CODE --------------

% Wavelength of color spectrum range red, orange, yellow, green, blue and
% purple
wavelen1 = [620, 590, 570, 495, 450, 380, 620];
wavelen2 = [750, 620, 590, 570, 495, 450, 750];
colrange = [0,20,50,80,165,255,300,360];

k = min(wavelen1);
d = max(wavelen2)-min(wavelen1);
j = find(colrange > hue, 1 );
hmx = colrange(j);
hmn = colrange(j-1);
if(j == 2)
    hmn = hmn - 60;
end
if(j == 8)
    hmx = hmx + 20;
end
wmx = wavelen2(j-1);
wmn = wavelen1(j-1);
hts = (wmx-(wmx-wmn)/(hmx-hmn)*(hue-hmn)-k)/d;

end

