function GPyr = GSS_2(im, s1, ns, noctaves)
if ~isfloat(im)
    im = im2double(im);
end

sigma = s1;
k = 2^(1/(ns)); 
GPyr = cell(noctaves,1);
[h, w] = size(im);
octave = zeros(h, w);

%generate starter kernal
m = sqrt(-2*(s1)*(s1)*log(1/100));
xy = -m:m;
[gx, gy] = deal(normpdf(xy, 0, sigma));

%creates first sub octave
sub = conv2(gx, gy, im, 'same');
scales(1,1) = sigma;
%adds the first sub octave to the 3d octave array
octave = sub;
save = [gx, gy];

for i = 2:ns + 3
    %create new sigma
    sigma = sqrt(k^2-1)*sigma;
    %create new kernal
    m = sqrt(-2*(sigma^2)*log(1/100));
    [gx, gy] = deal(normpdf((-m:m), 0, sigma));
    if i == ns
        save = [gx, gy];
    end
    %apply kernal
    sub = conv2(gx,gy,sub, 'same');
    octave = cat(3, octave, sub);
end
pause;
GPyr{1} = octave;

for i = 2:noctaves
    for j = 1:ns + 3
        
    end
end