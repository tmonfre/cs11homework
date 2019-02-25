% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Long Assignment 2: estimate motion of plants

clear;
load('image_matrices.mat');

% global constants for frame information
frameWidth = 60;
frameHeight = 45;
availFrames = length(p1images)-6; % there are three frames on either end that cannot be used for analysis

%% calculate partial derivatives

% instantiate matrix of partial derivatives for each pixel in each frame
p1derivs = zeros(frameHeight,frameWidth,3,availFrames);
p2derivs = zeros(frameHeight,frameWidth,3,availFrames);

% loop over available frames for analysis (frameNum indicates middle frame
% of 7-frame set that is currently being analyzed)
for frameNum=4 : 1 : availFrames-3
    
    % instantiate structs of frames
    p1f = struct('frame',{zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60)});
    p2f = struct('frame',{zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60)});

    % variable used to determine which frame to access
    imaccess = frameNum-3;
    
    % add to structs
    for k=0 : 1 : 6
        p1f(k+1).frame = p1images(:,:,imaccess+k);
        p2f(k+1).frame = p2images(:,:,imaccess+k);        
    end
    
    % calculate partial derivatives of space and time
    [p1derivs(:,:,1,frameNum-3),p1derivs(:,:,2,frameNum-3),p1derivs(:,:,3,frameNum-3)] = space_time_deriv(p1f);
    [p2derivs(:,:,1,frameNum-3),p2derivs(:,:,2,frameNum-3),p2derivs(:,:,3,frameNum-3)] = space_time_deriv(p2f);       
end

%% estimate motion

% instantiate matrix of vx and vy values for each pixel in each frame
p1motion = zeros(frameHeight,frameWidth,2,availFrames);
p2motion = zeros(frameHeight,frameWidth,2,availFrames);

% instantiate vectors of average vertical velocity
p1avg = zeros(availFrames,1);
p2avg = zeros(availFrames,1);

% loop over each frame in the collection
for frameNum=4 : 1 : availFrames-3
    % loop over each pixel
    for x=4 : 1 : frameWidth-3
        for y=4 : 1 : frameHeight-3
            
            % grab partial derivatives in the x
            p1fx = p1derivs(y-3:y+3, x-3:x+3, 1, frameNum-3);
            p1fx = reshape(p1fx,49,1);
            
            p2fx = p2derivs(y-3:y+3, x-3:x+3, 1, frameNum-3);
            p2fx = reshape(p2fx,49,1);
            
            % grab partial derivatives in the y
            p1fy = p1derivs(y-3:y+3, x-3:x+3, 2, frameNum-3);
            p1fy = reshape(p1fy,49,1);
            
            p2fy = p2derivs(y-3:y+3, x-3:x+3, 2, frameNum-3);
            p2fy = reshape(p2fy,49,1);
            
            % grab partial derivatives in the t
            p1ft = p1derivs(y-3:y+3, x-3:x+3, 3, frameNum-3);
            p1ft = reshape(p1ft,49,1);
            
            p2ft = p2derivs(y-3:y+3, x-3:x+3, 3, frameNum-3);
            p2ft = reshape(p2ft,49,1);
            
            % formulate matrix A - combine partials in x and y
            p1A = [p1fx p1fy];
            p2A = [p2fx p2fy];
            
            % calculate least-squares estimation for plant1
            p1gradient = sqrt(sum(p1fx.^2 + p1fy.^2));
            if cond(p1A'*p1A) < 100 && p1gradient > 10
                v = inv(p1A'*p1A) * -p1A' * p1ft;
                p1motion(y,x,:,frameNum-3) = v;
            end
            
            % calculate least-squares estimation for plant2
            p2gradient = sqrt(sum(p2fx.^2 + p2fy.^2));
            if cond(p2A'*p2A) < 100 && p2gradient > 10
                v = inv(p2A'*p2A) * -p2A' * p2ft;
                p2motion(y,x,:,frameNum-3) = v;
            end
        end
    end
    
    % compute average vertical motions for each frame
    p1avg(frameNum-3) = sum(sum(p1motion(:,:,2,frameNum-3))) / sum(sum(p1motion(:,:,2,frameNum-3)~=0));
    p2avg(frameNum-3) = sum(sum(p2motion(:,:,2,frameNum-3))) / sum(sum(p2motion(:,:,2,frameNum-3)~=0));
end

save('pixel_motion.mat','p1motion','p2motion','p1avg','p2avg');
