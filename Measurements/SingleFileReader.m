clc; clear;
fid = fopen('Measurement_5_mm.txt');
line1 = fgetl(fid);
res = line1;
while ischar(line1)
    line1 = fgetl(fid);
    res = char(res,line1);
end
fclose(fid);
res(122, :) = []; % This is the null line at the end of every file
res(121, :) = []; % This it the text line from the python work
%res(107, :) = [];
%res(106, :) = [];

S = std(res([1:30],:));
firstNonZero = find(S>0,1);
S(firstNonZero)
