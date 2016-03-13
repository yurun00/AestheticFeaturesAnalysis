function [bimg, thresh, ratio] = canny( gimg , threshold)

    [bimg, thresh] = edge(gimg, 'canny', threshold);
    ratio = sum(bimg(:))/numel(bimg);
    
end

