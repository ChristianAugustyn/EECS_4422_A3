function GPyr = GSS(im, s1, ns, noctaves)

if(~isfloat(im))
  im=im2double(im);
end
scales = zeros(noctaves, ns+3); %scales vector
k = 2^(1/(ns+3)); 
GPyr = cell(noctaves,1);
for i = 1:noctaves
    sigma = s1;
    [h, w]= size(im);
    %generate octave array
    oct = zeros(h, w);
% looping whithin an octave
    for j = 1:ns+3
        m = sqrt(-2*(sigma)*(sigma)*log(1/100));
        xy = -m:m;
        [hx, hy] = deal(normpdf(xy,0,sigma));
        g1 = conv2(hx,hy,im, 'same');
        %figure, imshow(g1, []);
        disp(sigma)
        scales(i, j) = sigma;
        sigma = k*sigma;
        %create the 3d array array of the sub-octaves that make up the
        %octave
        if j == 1
            oct = g1;
        else
            oct = cat(3, oct, g1);
        end 
        %helps to keep the sigma that is used after ns iterations
        if j == ns
            s1 = sigma;
        end 
    end
    GPyr(i) = {oct};
    im = imresize(im,0.5);
end


%apply padding
for i = 1:noctaves
    for j = 1:ns+3 %itterates over suboctaves
        scale = round(scales(i, j));
        [h, w] = size(GPyr{i}(:,:,j));
        
        %left border
        GPyr{i}(:,1:scale,j) = NaN;
        %right border
        GPyr{i}(:, w-scale:w,j) = NaN;
        %top border
        GPyr{i}(1:scale,:,j) = NaN;
        %bottom border
        GPyr{i}(h-scale:h,:,j) = NaN;
    end
end