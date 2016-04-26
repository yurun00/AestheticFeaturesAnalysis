function [glb_t,glb_w,glb_contrast] = Glbcolor(rgbimg)
[hue,tempscore] = ColorTemperature(rgbimg);
glb_t = mean(mean(tempscore));
weightscore = ColorWeight(rgbimg);
glb_w = mean(mean(weightscore));
[huedif, lumdif, satdif, huetempdif, weightdif]=Contrast(rgbimg);
glb_contrast(1,1) = huedif;
glb_contrast(1,2) = lumdif;
glb_contrast(1,3) = satdif;
glb_contrast(1,4) = huetempdif;
glb_contrast(1,5) = weightdif;