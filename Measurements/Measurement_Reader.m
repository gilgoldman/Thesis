% read from text file 
% This works, and retrieves the entire thing into a matrix named res
% Adds an empty line at the end
%clc; clear; close all;
strCell = {'Measurement_0_mm.txt',...
               'Measurement_1_mm.txt',...
               'Measurement_2_mm.txt',...
               'Measurement_3_mm.txt',...
               'Measurement_4_mm.txt',...
               'Measurement_5_mm.txt',...
               'Measurement_6_mm.txt',...
               'Measurement_7_mm.txt',...
               'Measurement_8_mm.txt',...
               'Measurement_9_mm.txt',...
               'Measurement_10_mm.txt',...
               'Measurement_11_mm.txt',...
               'Measurement_12_mm.txt',...
               'Measurement_13_mm.txt',...
               'Measurement_14_mm.txt',...
               };

sampleCount = [10 20 30 40 50 60 70 80 90 100];
resultMatrix = []; % Holds standard deviations(std) of each measurement
for samples = 1:length(sampleCount)
    samplesToBeUsed = sampleCount(samples);
    for i = 1:length(strCell) % This for loop reads the text files
        currentFile = strCell{i}; % this cycles through the files
        fid = fopen(currentFile);
        line1 = fgetl(fid);
        res=line1;
        while ischar(line1) 
            line1 = fgetl(fid);
            res = char(res,line1);
        end
        fclose(fid);
        if i<11 % This 'if' eliminates problematic lines at the end of files
            res(122, :) = []; % This is the null line at the end of every file
            res(121, :) = []; % This it the text line from the python work
        else
            res(107, :) = []; % This is the null line at the end of every file
            res(106, :) = []; % This it the text line from the python work
        end
    
        S = std(res([1:samplesToBeUsed],:)); % Selects how many samples are to be used for std
        %S = std(res);
        
        if (S(2) == 0)      
            firstNonZero = find(S>0,1); % Find the first non-zero value in the std vector
            STDArray(i) = S(firstNonZero); % Append it to the array of the results
        else
            STDArray(i) = S(2); % Append it to the array of the results  
        end
    end
    %STDArray
    resultMatrix = [resultMatrix ; STDArray]; % Appends the std result to the end of the result matrix
    % resultMatrix holds the results - each row is the standard deviation
    % of a predefined number of measurements across all files.
    % i.e - the first row is the standard deviations of the first 10
    % measurements of each file
end
Sfinal = [];
for i = 1:length(resultMatrix(:,1))
   Sfinal(i) = std(resultMatrix(i, :));
end

%t = 10:10:100;
%plot(t, Sfinal, 'bo-')
%xticks(10:10:100);
%xlabel('Number of readings sampled');
%ylabel('Standard Deviation');
%title('Standard Deviation compared to amount of readings taken');
%legend('Standard Deviation');
%saveas(gca,'test.pdf');
%system('pdfcrop test.pdf test.pdf');


% Plot the STD scatter plot
t = 1:length(resultMatrix(1,:));
%plot(t, resultMatrix(1,:), 'rx', t, resultMatrix(3, :), 'bx', t, resultMatrix(5, :), 'gx', t, resultMatrix(7, :), ...
%    'mx', t, resultMatrix(10, :), 'kx') 
% This is for the STD bar graph
vectorForBars = [resultMatrix(1,:);resultMatrix(3, :);resultMatrix(5, :);resultMatrix(7, :);resultMatrix(10, :)];
bar(vectorForBars')
% These are the plots parameters
xticks(1:15);
title('Standard deviation cross-sectional scatter plot');
xlabel('Distance moved by slide [cm]');
ylabel('Standard deviation [cm]');
legend('10 Measurements','30 Measurements','50 Measurements','70 Measurements','100 Measurements');
% For gca modification of axes size
% as used by set(lablerX,'FontSize',20) for example (10 is default)
lablerX = xlabel('Distance moved by slide [cm]');
lablerY = ylabel('Standard deviation [cm]');
legendary = legend('10 Measurements','30 Measurements','50 Measurements','70 Measurements','100 Measurements');
titular = title('Standard deviation cross-sectional scatter plot');
% This is the system verification plot
%SGRead = [1.001, 1.007, 1.009, 1.015, 1.029, 1.041];
%SGActual = [1.000, 1.005, 1.010, 1.015, 1.030, 1.040];
%barVector = [SGRead; SGActual];
%t = 1:6;
%bar(barVector')
%plot(t,SGRead, 'bo:', t, SGActual, 'ko:')
%xticks(1:6)
%title('Comparison between measured and actual Specific Gravity')
%ylabel('Specific Gravity')
%xlabel('Number of measurement')
%legend('Specific Gravity measured by device','Specific Gravity of test solution', 'Location', 'northwest')
