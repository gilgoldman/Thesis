clc; clear; close all;
fid = fopen('Measurement_4_mm.txt');
line1 = fgetl(fid);
res = line1;
while ischar(line1)
    line1 = fgetl(fid);
    res = char(res,line1);
end
fclose(fid);
%res(122, :) = [];
%res(121, :) = [];
%S = std(res);
%firstNonZero = find(S>0,1);
%S(firstNonZero)