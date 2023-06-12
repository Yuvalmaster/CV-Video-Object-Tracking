function [newX, newY, Mask, limitsMask] = meanShift(testBP, I, x0, y0, radius, maxIters, tol)
    %% Initialize inputs & parameters
    testBP     = double(testBP);
    %I          = double(I);
    Mask       = zeros(size(I,1),size(I,2));
    limitsMask = zeros(size(I,1),size(I,2));
    M00 = 0; M10 = 0; M01 = 0;

    %%  MeanShift Iterations
    iter = 0; % Start iterations
    while iter < maxIters
        for X=1:size(I,1)
            for Y=1:size(I,2)
                % Validate the X,Y are within the Circle bounds
                Mask(X,Y) = sqrt(abs(X-x0).^2 + abs(Y-y0).^2) <= radius;        
                
                % If the coordinates are within the Circle bounds
                if Mask(X,Y) ~= 0
                M00 = M00 + testBP(X,Y);
                M10 = M10 + X*testBP(X,Y);
                M01 = M01 + Y*testBP(X,Y);
                end
            end
        end
        
        % Set new coordinates
        newX = M10/M00; newY = M01/M00;
        
        % Test if new corrdinates are within tolerance
        if sqrt(abs(x0-newX).^2 + abs(y0-newY).^2) < tol
            break
        else
            % Initiate new iteration
            x0 = newX; y0 = newY;       % Set new starting coordinates
            M00 = 0; M10 = 0; M01 = 0;  % Reset variables
            iter = iter+1;
        end
    end

    %% Create limitsMask

    for X=1:size(I,1)
        for Y=1:size(I,2)
            limitsMask(X,Y) = sqrt(abs(X-newX).^2 + abs(Y-newY).^2) <= radius + 10 &...
                              sqrt(abs(X-newX).^2 + abs(Y-newY).^2) >= radius - 10;
        end
    end
end