function J = boundsTrackedObject(I, objLimits)
    % Create the circle object
    circle = repmat(permute(uint8([255 0 0]),[1 3 2]),[size(I,1), size(I,2)]);
    circle = circle.*repmat(uint8(objLimits),1,1,3);
    
    % Add the circle object to the image
    J = I + circle;
end