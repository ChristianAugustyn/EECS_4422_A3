im = rgb2gray(imread('mondrian.jpg'));
s1 = 1.6;
ns = 3;
noctaves = 3;
GPyr = GSS(im, s1, ns, noctaves);
showPyr(GPyr, ns);