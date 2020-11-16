function DoGPyr = DoGSS(GPyr)
 noctaves = length(GPyr);
 DoGPyr = cell(noctaves,1);
 
 for i = 1:3
     temp = GPyr{i};
     DoGPyr{i} = diff(temp,1,3);
 end