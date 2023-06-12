function mask = ComputeGreenMask(I)
    % Convert the frame to the HSV color space
    HSV_frame  = rgb2hsv(I);

    % Define the range of green color (Hue, Sat, Val)
    colorRange = [0.18, 0.1, 0.45; 0.45, 1.0, 1.0];

    % Create the mask
    mask = (HSV_frame(:,:,1) >= colorRange(1,1) & HSV_frame(:,:,1) <= colorRange(2,1)) & ...
           (HSV_frame(:,:,2) >= colorRange(1,2) & HSV_frame(:,:,2) <= colorRange(2,2)) & ...
           (HSV_frame(:,:,3) >= colorRange(1,3) & HSV_frame(:,:,3) <= colorRange(2,3));
end