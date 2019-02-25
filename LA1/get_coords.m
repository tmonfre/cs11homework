% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Long Assignment 1: function to select points from a video frame then save
% said coordinates for later use

function [] = get_coords(videoFile, outputFile, skip)

% load video object
vidObj = VideoReader(videoFile);

% calculate number of frames to be selected
nframes = (round(vidObj.Duration * vidObj.FrameRate)) / skip;

% create empty four-dimension matrix
% height x width x num channels x num frames
frames = zeros(vidObj.Height, vidObj.Width, 3, nframes);

% create empty nx2 matrix, where n is the number of frames to be selected
coords = zeros(nframes,2);

% keep placeholder into coords such that changing values will not required
% significant memory allocation -- will be more efficient in the process
coordsCount = 1;

% keep count of what frame we are on
frameCount = 0;

% loop over all frames in the video, prompt the user to select x,y
% coordinates at each frame
while hasFrame(vidObj)
    % read and display the frame
    frame = readFrame(vidObj);
    imshow(frame);
    drawnow;
    
    % if this is a frame on the skip-th iteration, record location & frame
    if mod(frameCount,skip) == 0
        
        % record frame
        frames(:,:,:,coordsCount) = frame;
        
        % grab user input
        [x,y] = ginput(1);
        
        % store in coords, instantiate placeholder
        coords(coordsCount,:) = [x,y];
        coordsCount = coordsCount + 1;
       
    end
    
    % instantiate count regardless of frame
    frameCount = frameCount + 1;
    
end

% save variables coords and frames to the output file
save(outputFile, 'coords', 'frames');

end
