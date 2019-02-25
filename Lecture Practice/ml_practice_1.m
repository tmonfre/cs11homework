clear;

% formulate matrix A
A = 1:16;
A = reshape(A,4,4)';

% compute mean of third row
fprintf('Mean of third row: %f \n', mean(A(3,:)))

% compute min of each row
fprintf('Min of row one:   %d \n', min(A(1,:)))
fprintf('Min of row two:   %d \n', min(A(2,:)))
fprintf('Min of row three: %d \n', min(A(3,:)))
fprintf('Min of row four:  %d \n', min(A(4,:)))

% compute max of each column
fprintf('Max of col one:   %d \n', max(A(:,1)))
fprintf('Max of col two:   %d \n', max(A(:,2)))
fprintf('Max of col three: %d \n', max(A(:,3)))
fprintf('Max of col four:  %d \n', max(A(:,4)))

B = inv(A)*[9 10 11 12 ; 5 6 7 8 ; 1 2 3 4 ; 13 14 15 16];