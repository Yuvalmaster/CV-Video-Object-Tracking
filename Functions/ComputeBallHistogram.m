function ballHistogram = ComputeBallHistogram(I, mask, nbbins)    
    % Convert the frame to the HSV color space
    HSV_mask = mask.*double(I);
    HSV_I    = rgb2hsv(HSV_mask);
    %HSV_mask = HSV_mask(HSV_mask~=0);
    
    % Create ballHistogram Parameters
    [values, BinEdges]  = histcounts(HSV_I(:,:,1), nbbins);
    NumBins             = nbbins;
    ballHistogram       = {values,BinEdges,NumBins};

end