function kp = SSExtrema(DoGPyr)
noctaves = length(DoGPyr);
kp = cell(noctaves,1);
for octave = 1:noctaves %octaves
    oim = DoGPyr{octave};
    [h,w,s] = size(oim);
    ns = s-2;
    kpo = cell(ns,1);
    nbim = zeros([size(oim,1),size(oim,2),27]); %will contain neighbourhood images
    for s = 1:ns %ns
        oims = oim(:,:,s:s+2); %Neighborhood of scale s+1
        idx = 1;
        %This nested loop converts the 3x3x3-neighbourhood of each pixel in
        %scalespace into a 27-channel vector nbim
        count = 0;
        for di = -1:1
            for dj = -1:1
                for dk = -1:1
                    oimshift = circshift(circshift(circshift(oims,di,1),dj,2),dk,3);
                    nbim(:,:,idx) = oimshift(:,:,2);
                    idx = idx + 1;
                end
            end
        end
        [M,I] = max(nbim, [],3,'includenan'); %max in neighbourhood
        val = M(I == 14); %max is central pixel
        [y,x] = find(I == 14); 
        kpo{s}.max = [x,y,val];
        [M,I] = min(nbim,[],3,'includenan');
        val = M(I == 14); %min is central pixel
        [y,x] = find(I == 14);
        kpo{s}.min = [x,y,val];
    end
    kp{octave} = kpo;
end
