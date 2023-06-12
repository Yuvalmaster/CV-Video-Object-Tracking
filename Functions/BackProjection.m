function testBP = BackProjection(I,ballHistogram)
    % Convert the frame to the HSV color space
    HSV_I = rgb2hsv(I);

    % Set Histogram parameters for backProjection
    BinEdges = ballHistogram{2};
    BinEdges = BinEdges(2:end); % Ignore first edge to find the correct bin
    
    values   = ballHistogram{1};
    %nbbins   = ballHistogram{3};
    
    % Loop over all pixels in the image
    testBP = zeros(size(I,1),size(I,2));
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            % Compute the hue value of the current pixel
            pix_hue = HSV_I(i,j,1);
            
            % Find the bin in the histogram that corresponds to the hue value
            [~,bin] = min(abs(BinEdges - pix_hue));

            % Assign the value of the bin to the pixel in the probability map
            testBP(i,j) = values(bin);
        end
    end

    % Create a filter to lower overall noise in output image - minimizes
    % large prominent stain outside the object bounds
    testBP = uint8(testBP);
    testBP = medfilt2(testBP, [50 50], "zeros");
end