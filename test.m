im = rgb2gray(imread('mondrian.jpg'));
imshow(im);
s1 = 1.6;
ns = 3;
noctaves = 3;
if(~isfloat(im))
  im=im2double(im);
end
scales = zeros(noctaves, ns+3); %scales vector
k = 2^(1/(ns+3)); 
GPyr = cell(noctaves,1);
for i=1:noctaves
    sigma = s1;
    [h, w]= size(im);
% looping whithin an octave
    for j=1:ns+3
        m = sqrt(-2*(sigma)*(sigma)*log(1/100));
        x = -m:m;
        y = -m:m;
        hx = normpdf(x,0,sigma);
        hy = normpdf(y,0,sigma);
        g1 = conv2(hx,hy,im, 'same');
%         g1 = imgaussfilt(im, sigma);
        figure, imshow(g1, []);
        disp(sigma)
        scales(i, j) = sigma;
%Numer_of_cell_filled = j
        sigma = k*sigma;
        if j == ns
            s1 = sigma;
        end 
    end
  
    GPyr(i) = {g1};
    im = imresize(im,0.5);
  
end
