addpath(strcat(pwd,'\Functions'))
function [mask,ballHistogram] = RUN(imageFilename,videoFilename)    
    dbstop if error
    %
    %% Load Data
    I = imread(imageFilename);
    vidObj = VideoReader(videoFilename);
    
    %% Create Green Mask
    mask = ComputeGreenMask(I);
    figure(1); imshow(I.*repmat(uint8(mask),1,1,3));
    
    %% Ball Histogram
    ballHistogram = ComputeBallHistogram(I, mask, 100);
    
    
    %% Back Projection
    testBP = BackProjection(I,ballHistogram);
    figure(2); imshow(testBP,[]);
    
    %% Track Object
    [~,~,~,objLimits] = meanShift(testBP,I,900,900,300,10,10);
    I = boundsTrackedObject(I,objLimits);
    figure(3);
    imshow(I);
    drawnow
    
    
    %nFrames = vidObj.Duration * vidObj.FrameRate;
    %vidHeight = vidObj.Height;
    %vidWidth = vidObj.Width;
    
    writer = VideoWriter(strcat(pwd,'\Output\myLocatedBalls.avi'));
    open(writer);
    
    xc=200;
    yc=400;
    k=0;
    outOfField = 0;
    
    while hasFrame(vidObj)
     k=k+1;
     I = readFrame(vidObj);
     msg=['Processing frame ' num2str(k) '...'];
     disp(msg);
     testBP = BackProjection(I,ballHistogram);
     [xcn,ycn,~,objLimits] = meanShift(testBP,I,xc,yc,200,10,10);
    
    
     if ~isnan(xcn),
     xc=xcn;
     outOfField = outOfField +1;
     end
     
     if ~isnan(ycn),
     yc=ycn;
     outOfField = outOfField +1;
     end
     
     if outOfField==30,
     outOfField = 0;
     testBP = BackProjection(I,ballHistogram);
     [li,co] = find(testBP == max(max(testBP)));
     xc=round(mean(li));
     yc=round(mean(co));
     end
     
     I = boundsTrackedObject(I,objLimits);
     writeVideo(writer,I);
    end
    
    close(writer);

end


