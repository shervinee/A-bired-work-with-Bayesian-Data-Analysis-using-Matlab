%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                       Bayesian Data Analysis
%                       and Signal Processing
%
%                    A PHY 451/551 and I CSI 451/551
%                             FALL 2011
%
%                     Instructor: Kevin H. Knuth
%
%
% HW 3p
% Introduction to Global Warming Data
%
% The purpose of this homework set is to introduce you to data analysis in
% Matlab.  This importing data into Matlab and performing basic manipulations.
%
% We will perform some *crude* analyses of atmospheric CO2 data.
%
% TURN IN:
% Zip file containing:
%    1. this M-file with your code inserted
%    2. The MAT-files containing the data as instructed below
%    3. A report summarizing your work, illustrating your results (figures) and discussing your answers to the questions posed below.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Problem by: Kevin H. Knuth
% Created on: 8 August 2006
% Modified on: 22 Sept 2011
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Download (or unzip) the Vostok Ice Core Sample Data Set
% Import them into Matlab using the Import Data function in the File Menu
% Restructure the data into two arrays:
% vyear <1x363>   - years BP (before present, which was 2003)
% vco2  <1x363>   - co2 concentration in ppm
% V               - number of measurements


% save the results in a mat-file
%
% These data are provided courtesy of:
% Historical carbon dioxide record from the Vostok ice core
% J.-M. Barnola, D. Raynaud, C. Lorius
% Laboratoire de Glaciologie et de Géophysique de l'Environnement, CNRS,
% BP96, 38402 Saint Martin d'Heres Cedex, France 
% and
% N.I. Barkov
% Arctic and Antarctic Research Institute, Beringa Street 38, 199397, St.
% Petersburg, Russia


 k = 0; %to loop through data
 vyear = zeros(1,363); %initialization for a better speed 
 vco2 = zeros (1,363); %initialization for a better speed
 for i = 1:363
     k = k+1;
     vyear(k)=vostokicecoreco2(i,3);
     vco2(k)=vostokicecoreco2(i,4);
     
 end
 V = length(vco2);
    


% Plot the CO2 levels over time


subplot(2,2,1)
plot(vyear,vco2)
xlabel('Time in years before 2003')
ylabel('CO2 concentration in ppm')
title('CO2 level over time (Vostok)')


% QUESTIONS TO DISCUSS IN YOUR REPORT
% What is the range of variability of the CO2 levels?
range = max(vco2) - min(vco2)
% Compute the mean and standard deviation of the CO2 levels?
Average = sum(vco2)/V
sd = std(vco2)
% Plot a histogram of the CO2 levels?

subplot(2,2,2);
hist(vco2);
xlabel('CO2 concentration in ppm')
ylabel('number of elements in each bin')
title('histogram of the CO2 levels (Vostok)')




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Download (or unzip) the Mauna Loa Atmopheric Sample Data Set
% Import them into Matlab using the Import Data function in the File Menu
% Restructure the data and save them in these arrays:
% myear  <1x557>   - year
% mmonth <1x557>   - month
% mtime  <1x557>   - time in years
% mco2   <1x557>   - co2 concentration in ppm
% M                - number of measurements
% save the results in a mat-file
% WARNING: THERE ARE MISSING DATA VALUES THAT YOU MUST DEAL WITH.
% Dont interpolate them, just omit them from the data array.
%
% These data are provided courtesy of:
% Atmospheric carbon dioxide record from Mauna Loa
% C.D. Keeling and T.P. Whorf
% Carbon Dioxide Research Group, Scripps Institution of Oceanography,
% University of California, La Jolla, California 92093-0444, U.S.A.


k=0;%we?re gonna count which one is good
T = size(maunaloaco2,1);
myear = zeros(1,557);
mmonth = zeros(1,557);
mco2 = zeros(1,557);
mtime = zeros(1,557);
for i =1 : 47  %it gets the first dimension %number of rows 2 gets the number of columns    
    for j =2:13
        if(maunaloaco2(i,j) < 0 )
            %bad data
        else
            k = k+1;
            %good data keep it
            myear(k) = maunaloaco2(i,1);
            mmonth(k) = j-1;
            mco2 (k) = maunaloaco2(i,j);
            mtime(k) = myear(k)-1958; %if we take 1958 year as the origin of our time 
        end
    end
end
M = length(myear);


% QUESTIONS TO DISCUSS IN YOUR REPORT
% -Plot the CO2 levels over modern times
subplot(2,2,3)
plot(mtime,mco2);
xlabel('time in years');
ylabel('concentration of CO2');
title('CO2 levels over modern times (maunaloa)');
% -Can you determine (roughly) the period of the oscillations?

% -What could cause this?




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine the two data sets by concatenating the arrays
% time  <1x920>   - time in years
% co2   <1x920>   - co2 concentration in ppm
% S = V + M       - number of measurements
% Remember that the Vostok data is in years before present, while the Mauna
% Loa data are real dates.



time = [2003-myear,vyear];
co2 = [mco2,vco2];
S = M + V ;

% Plot the CO2 levels over time


subplot(2,2,4)
plot(time,co2);
xlabel('time in years before 2003');
ylabel('Concentration of co2');
title('combined CO2 levels over time');


% QUESTIONS TO DISCUSS IN YOUR REPORT
% - What is the CO2 level in May 1986? Based on maunaloaco2
maunaloaco2(29,6)
% - Given the calculated one standard deviation calculated using the Vostok ice core sample,
%   is it likely that this modern spike is just one of many natural fluctuations?
Mean = sum(mco2)/M

% - Can you estimate the probability that this modern spike is a natural fluctuation? (extra credit)

% - What is compelling about this analysis?
% - Why is this analysis insufficient?
