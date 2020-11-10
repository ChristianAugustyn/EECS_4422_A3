function GPyr = GSS(im, s1, ns, noctaves)
%Creates a Gaussian pyramid representation of an image.  

%Input:
%im:        The input image
%s1:        Base scale constant  
%ns:        Number of sub-octave scales
%noctaves   Number of octaves

%Output:
%GPyr is a MATLAB cell array of length noctaves containing the Gaussian pyramid. 
%Each element of the array is a 3D array containing ns + 3 sub-octave images
%This allows computation of ns + 2 DoG images, and thus detection of ns
%extrema of DoG features over scale.
    [row, col] = size(im);
    n = 1;
    ss = zeros(row, col, n);
    k = 2^(1/(ns + 3));
    pyr = cell(noctaves, 1);
    
    for i = 1:noctaves
        sigma = s1;
        [h, w] = size(im);
        l = zeros(h, w);

        for j = 1:ns+3
            n = sqrt(-2*(sigma^2)*log(1/100));
            x = linespace(-n, n);
            y = linespace(-n, n);
            
            hx = normpdf(x, 0, sigma);
            hy = normpdf(y, 0, sigma);
            
            g1 = conv2(hx, hy, im, 'valid');
            size_adjust = ceil((size(im) - size(g1))/2)-1;
            g1 = padarray(g1, size_adjust, 999);
            
            g1(size(g1, 1)+1, :) = 'NaNs';
            g1(:, size(g1, 2)+1) = 'Nans';
            
            if l~=zeros()
                l = cat(3, l, g1);
            else
                l = g1;
            end
            
            sigma = k * sigma;
            
            
        end 
        pyr(1) = {1};
        im = imresize(im, 0.5);
    end
    
    Gypr = pyr;
end

