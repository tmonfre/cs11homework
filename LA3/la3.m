% Thomas Monfre
% Dartmouth College CS 11, Spring 2018
% Long Assignment 3: use estimation-maximization to create a parts
% inspection system that fits images to a specified tolerance

clear;

% create global variables for information pertaining to images
numImages = 5;
imageDimension = 466;
CONVERGE_VAL = 0.1; % limit/value for successful convergence

% loop over each image in the collection, load image, calculate
% estimation-maximization and visualize until convergence is met
for imNum = 1 : numImages
    %% image setup
    
    % load image, store colored version, convert to grayscale
    filename = sprintf('discs/disc%d.jpg',imNum);
    colorim = imread(filename);
    grayim = rgb2gray(colorim);

    % create matrix of salient edge pixels with non-zero value 
    [rows, cols] = find(edge(grayim));
    edges = [rows cols];
    
    %% estimation-maximization
    
    % initialize original image variable values -- originally set to inf so
    % while loop will begin iteration (old values are updated in loop)
    old_cx = inf;
    old_cy = inf;
    old_r = inf;
    
    % initialize image variable values to be updated
    cx = 233;
    cy = 233;
    r = 190;
    sig = 8;
    
    % initialize difference between iterative steps for image variables
    cx_diff = abs(old_cx-cx);
    cy_diff = abs(old_cy-cy);
    r_diff  = abs(old_r-r);
    
    % keep track of how many attempts it takes to get a predicted fit
    attempt = 0;
    
    % continue to calculate estimation-maximization until satisfactory 
    % convergence values for cx, cy and r are met
    while cx_diff > CONVERGE_VAL || cy_diff > CONVERGE_VAL || r_diff > CONVERGE_VAL
        %% E-step
        
        % get x and y values from edges -- pack into nx1 vectors 
        x = edges(:,1);
        y = edges(:,2);
        
        % calculate residual errors for each point
        d = abs(sqrt((x-cx).^2 + (y-cy).^2) - r);
        
        % calculate probability of residual given point
        probR_PX = (1/(sqrt(2*pi*(sig^2)))) * exp((-(d.^2))/(2*(sig^2)));
        
        % calculate and store probability that pixel x,y belongs to
        % the circle with center cx,cy and radius r
        edgesProbs = (probR_PX ./ (probR_PX + 0.1));
        
        %% M-step
        
        % formulate matrix B of knowns and W of weights for least squares
        B = [((x.^2) + (y.^2)) x y ones(length(edges),1)];
        W = diag(edgesProbs);
        
        % solve for vector u of unknowns using weighted total least squares
        % use Rayleigh Quotient to constrain u to unit length and thus
        % avoid a degenerate solution
        X = W*B; % weight matrix B, then solve
        [V,D] = eig(X'*X);
        u = V(:,1);
        b = [u(2) u(3)]'; % combine b1 and b2 to vector b
        
        % store old cx,cy,r values
        old_cx = cx;
        old_cy = cy;
        old_r = r;
        
        % convert the parameterization of the circle from least squares
        % back to cx,cy,r
        cx = (-(u(2))/(2*u(1)));
        cy = (-(u(3))/(2*u(1)));
        r = sqrt( ((b'*b)/(4*(u(1)^2))) - (u(4)/u(1)) );
        
        
        %% update variables used in estimation
        
        % update sigma
        sig = sqrt(sum((edgesProbs.*(d.^2))/sum(edgesProbs)));
                
        % update difference metrics
        cx_diff = abs(old_cx-cx);
        cy_diff = abs(old_cy-cy);
        r_diff = abs(old_r-r);
        
        % update the attempt number
        attempt = attempt + 1;
        
        %% visualize output
        
        % display images and circle
        subplot(1,2,1);
        imshow(colorim); % display color version of image
        title(sprintf('Image %d Attempt %d',imNum,attempt));
        hold on;
        
        % display predicted circle
        theta = 0 : 0.01 : 2*pi;
        circX = r * cos(theta) + cx;
        circY = r * sin(theta) + cy;
        h = plot(circY, circX,'r');
        set(h,'LineWidth',2);
        
        % display predicted center
        plot(cy,cx,'bo');
        hold off;
        
         % create binary image of pixel probabilities
        binaryIm = zeros(imageDimension,imageDimension);
        
        % each pixel with a probability has value set to that probability
        for px=1 : length(edgesProbs)
            dispProb = max(edgesProbs(px),edgesProbs(px)*10); % multiply by 10 to assist visualization
            binaryIm(edges(px,1),edges(px,2)) = dispProb;
        end
        
        % display binary image of pixel probabilities
        subplot(1,2,2);
        imshow(binaryIm);
        title('Binary Image of Probabilities');
        
        pause(0.01);
        
    end
    fprintf('Finished image %d \n',imNum);
    
    %% to confirm convergence, display the final image and circle in green
    
    % display image
    subplot(1,2,1);
    imshow(colorim); % display color version of image
    title(sprintf('Image %d Attempt %d',imNum,attempt));
    hold on;

    % display predicted circle
    theta = 0 : 0.01 : 2*pi;
    circX = r * cos(theta) + cx;
    circY = r * sin(theta) + cy;
    h = plot(circY, circX,'g');
    set(h,'LineWidth',2);

    % display predicted center
    plot(cy,cx,'bo');
    hold off;
    
    % if not on the last image, pause after execution so user can assess
    % the quality of the estimation and optimization
    if imNum < numImages
        pause;
    end
end