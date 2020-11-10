im = rgb2gray(imread('mondrian.jpg'));
imshow(im);
s1 = 1.6;
ns = 3;
noctaves = 3;
%GPyr = GSS(im, s1, ns, noctaves);
%showPyr(DoGPyr,ns);
%If Image is not floating point type, we convert it
if(~isfloat(im))
  im=im2double(im);
end

% An empty matrix for the scale space
[h, w]= size(im);
%n=1;
%scale_space = zeros(h,w,n);
%k=1;
k = 2^(1/(ns+3));
    
%GPyr = cell(ns,2,noctaves);
GPyr = cell(noctaves,1);
%%gg = randi()


for i=1:noctaves
    sigma = s1;

    [h, w]= size(im);
    l = zeros(h,w);
% looping whithin an octave
    for j=1:ns+3
        m = sqrt(-2*(sigma)*(sigma)*log(1/100));
        %x = linspace(-m,m,6*sigma+1);
        x = linspace(-m,m);
        y = linspace(-m,m);
        hx = normpdf(x,0,sigma);
        hy = normpdf(y,0,sigma);
        %640 x 1280
        g1 = conv2(hx,hy,im,'valid');
        size_adjust = ceil((size(im) - size(g1))/2)-1;
        g1 = padarray(g1,size_adjust,'NaNs');
        % Adding one more colum and row to 2 sides
        g1(size(g1,1)+1,:) = "NaNs";
        g1(:,size(g1,2)+1) = "NaNs";
        g1(g1==999) = "NaNs";
        size(g1)
        figure, imshow(g1,[]);
 
        if l~=zeros()
            l = cat(3,l,g1);
        else
            l = g1;
        end

%Numer_of_cell_filled = j
        sigma = k*sigma;

    end
  
    GPyr(i) = {l};
    im = imresize(im,0.5);
  
end
