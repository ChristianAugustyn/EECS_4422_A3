function [g1x, g1y, g1mag] = g1(im, s)
   % convert image to luminance
   im = rgb2gray(im);
   func = -3*s:3*s;
   var_x = normpdf(func,0,s);
   deriv_x = var_x.*(-func/s^2);
   deriv_y = deriv_x';
   g1x = conv2(conv2(im, deriv_x, 'same'), var_x', 'same');
   g1y = conv2(conv2(im, deriv_y, 'same'), var_x, 'same');
   g1mag = sqrt(g1x.^2 + g1y.^2);
end