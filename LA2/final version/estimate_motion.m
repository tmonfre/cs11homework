% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Long Assignment 2: estimate motion of plants

clear;
load('image_matrices.mat');

% global constants for frame information
frameWidth = 60;
frameHeight = 45;
availFrames = length(images)-6; % there are three frames on either end that cannot be used for analysis

% instantiate matrix of partial derivatives for each pixel in each frame
derivs = zeros(frameHeight,frameWidth,3,availFrames,2);

% instantiate matrix of vx and vy values for each pixel in each frame
motion = zeros(frameHeight,frameWidth,2,availFrames,2);

% instantiate vectors of average vertical velocity
avg = zeros(availFrames,2);

% perform each action for each directory of plant images
for plant=1:2
    %% calculate partial derivatives
    
    % loop over available frames and calculate partial derivatives
    for frameNum=1 : 1 : availFrames

        % instantiate structs of frames
        f = struct('frame',{zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60),zeros(45,60)});

        % variable used to determine which frame to access
        imaccess = frameNum;

        % add to structs
        for k=0 : 1 : 6
            f(k+1).frame = images(:,:,imaccess+k,plant);     
        end

        % calculate partial derivatives of space and time
        [derivs(:,:,1,frameNum,plant),derivs(:,:,2,frameNum,plant),derivs(:,:,3,frameNum,plant)] = space_time_deriv(f);       
    end
    
    %% estimate motion

    % loop over each frame in the collection and calculate vx and vy
    for frameNum=1 : 1 : availFrames
        % loop over each pixel
        for x=4 : 1 : frameWidth-3
            for y=4 : 1 : frameHeight-3

                % grab partial derivatives in the x
                fx = derivs(y-3:y+3, x-3:x+3, 1, frameNum,plant);
                fx = reshape(fx,49,1);

                % grab partial derivatives in the y
                fy = derivs(y-3:y+3, x-3:x+3, 2, frameNum,plant);
                fy = reshape(fy,49,1);

                % grab partial derivatives in the t
                ft = derivs(y-3:y+3, x-3:x+3, 3, frameNum,plant);
                ft = reshape(ft,49,1);

                % formulate matrix A - combine partials in x and y
                A = [fx fy];

                % calculate least-squares estimation - ensure zero values
                % for unsatisfactory condition and gradient by initially
                % instantiating motion as matrix of zeros
                gradient = sqrt(sum(fx.^2 + fy.^2));
                if cond(A'*A) < 100 && gradient > 10
                    v = inv(A'*A) * -A' * ft;
                    motion(y,x,:,frameNum,plant) = v;
                end
            end
        end

        % compute average vertical motions for each frame - ensure zero
        % values are ignored with ~=0
        avg(frameNum,plant) = sum(sum(motion(:,:,2,frameNum,plant))) / sum(sum(motion(:,:,2,frameNum,plant))~=0);
    end
end

save('pixel_motion.mat','motion','avg');