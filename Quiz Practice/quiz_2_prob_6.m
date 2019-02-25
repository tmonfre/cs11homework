clear;

h1 = uicontrol;
set(h1, 'Units', 'normalized');
set(h1, 'Style', 'Slider');
set(h1, 'Min', 0, 'Max', 1, 'Value', 1);

%set(h1, 'Callback', 'im_adjust');

im = imread('mandrill.jpg');

imshow(im);
drawnow;

