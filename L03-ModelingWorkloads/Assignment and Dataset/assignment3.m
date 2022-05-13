clearvars;


data1 = readmatrix("Data1.txt");
[m1_1, m2_1, m3_1, m4_1] = moments(data1);
[m2c_1, m3c_1, m4c_1] = moments_centered(data1);
[m3s_1, m4s_1] = moments_standardized(data1);
stdDev_1 = sqrt(m2c_1);
coeffVar_1 = stdDev_1/m1_1;
kurtosis_1 = m4s_1-3;
crossCov1_1 = cross_covariance(data1,1);
crossCov2_1 = cross_covariance(data1,2);
crossCov3_1 = cross_covariance(data1,3);
crossCov4_1 = cross_covariance(data1,4);
perc90_1    = perc_linInt(data1,90);
perc75_1    = perc_linInt(data1,75);
perc50_1    = perc_linInt(data1,50);
perc25_1    = perc_linInt(data1,25);
perc10_1    = perc_linInt(data1,10);
fprintf("\nTrace 1\n")
fprintf("first moment: %d\n", m1_1)
fprintf("second moment: %d\n", m2_1)
fprintf("third moment: %d\n", m3_1)
fprintf("fourth moment: %d\n", m4_1)
fprintf("second centered moment: %d\n", m2c_1)
fprintf("third centered moment: %d\n", m3c_1)
fprintf("fourth centered moment: %d\n", m4c_1)
fprintf("third standardized moment: %d\n", m3s_1)
fprintf("fourth standardized moment: %d\n", m4s_1)
fprintf("standard deviation: %d\n", stdDev_1)
fprintf("coefficient of variation: %d\n", coeffVar_1)
fprintf("kurtosys: %d\n", kurtosis_1)
fprintf("90 percentile: %d\n", perc90_1)
fprintf("75 percentile: %d\n", perc75_1)
fprintf("50 percentile: %d\n", perc50_1)
fprintf("25 percentile: %d\n", perc25_1)
fprintf("10 percentile: %d\n", perc10_1)
fprintf("cross covariance of step 1: %d\n", crossCov1_1)
fprintf("cross covariance of step 2: %d\n", crossCov2_1)
fprintf("cross covariance of step 3: %d\n", crossCov3_1)
fprintf("cross covariance of step 4: %d\n", crossCov4_1)

data2 = readmatrix("Data2.txt");
[m1_2, m2_2, m3_2, m4_2] = moments(data2);
[m2c_2, m3c_2, m4c_2] = moments_centered(data2);
[m3s_2, m4s_2] = moments_standardized(data2);
stdDev_2 = sqrt(m2c_2);
coeffVar_2 = stdDev_2/m1_2;
kurtosis_2 = m4s_2-3;
crossCov1_2 = cross_covariance(data2,1);
crossCov2_2 = cross_covariance(data2,2);
crossCov3_2 = cross_covariance(data2,3);
crossCov4_2 = cross_covariance(data2,4);
perc90_2    = perc_linInt(data2,90);
perc75_2    = perc_linInt(data2,75);
perc50_2    = perc_linInt(data2,50);
perc25_2    = perc_linInt(data2,25);
perc10_2    = perc_linInt(data2,10);

fprintf("\nTrace 2\n")
fprintf("first moment: %d\n", m1_2)
fprintf("second moment: %d\n", m2_2)
fprintf("third moment: %d\n", m3_2)
fprintf("fourth moment: %d\n", m4_2)
fprintf("second centered moment: %d\n", m2c_2)
fprintf("third centered moment: %d\n", m3c_2)
fprintf("fourth centered moment: %d\n", m4c_2)
fprintf("third standardized moment: %d\n", m3s_2)
fprintf("fourth standardized moment: %d\n", m4s_2)
fprintf("standard deviation: %d\n", stdDev_2)
fprintf("coefficient of variation: %d\n", coeffVar_2)
fprintf("kurtosys: %d\n", kurtosis_2)
fprintf("90 percentile: %d\n", perc90_2)
fprintf("75 percentile: %d\n", perc75_2)
fprintf("50 percentile: %d\n", perc50_2)
fprintf("25 percentile: %d\n", perc25_2)
fprintf("10 percentile: %d\n", perc10_2)
fprintf("cross covariance of step 1: %d\n", crossCov1_2)
fprintf("cross covariance of step 2: %d\n", crossCov2_2)
fprintf("cross covariance of step 3: %d\n", crossCov3_2)
fprintf("cross covariance of step 4: %d\n", crossCov4_2)

data3 = readmatrix("Data3.txt");
[m1_3, m2_3, m3_3, m4_3] = moments(data3);
[m2c_3, m3c_3, m4c_3] = moments_centered(data3);
[m3s_3, m4s_3] = moments_standardized(data3);
stdDev_3 = sqrt(m2c_3);
coeffVar_3 = stdDev_3/m1_3;
kurtosis_3 = m4s_3-3;
crossCov1_3 = cross_covariance(data3,1);
crossCov2_3 = cross_covariance(data3,2);
crossCov3_3 = cross_covariance(data3,3);
crossCov4_3 = cross_covariance(data3,4);
perc90_3    = perc_linInt(data3,90);
perc75_3    = perc_linInt(data3,75);
perc50_3    = perc_linInt(data3,50);
perc25_3    = perc_linInt(data3,25);
perc10_3    = perc_linInt(data3,10);

fprintf("\nTrace 3\n")
fprintf("first moment: %d\n", m1_3)
fprintf("second moment: %d\n", m2_3)
fprintf("third moment: %d\n", m3_3)
fprintf("fourth moment: %d\n", m4_3)
fprintf("second centered moment: %d\n", m2c_3)
fprintf("third centered moment: %d\n", m3c_3)
fprintf("fourth centered moment: %d\n", m4c_3)
fprintf("third standardized moment: %d\n", m3s_3)
fprintf("fourth standardized moment: %d\n", m4s_3)
fprintf("standard deviation: %d\n", stdDev_3)
fprintf("coefficient of variation: %d\n", coeffVar_3)
fprintf("kurtosys: %d\n", kurtosis_3)
fprintf("90 percentile: %d\n", perc90_3)
fprintf("75 percentile: %d\n", perc75_3)
fprintf("50 percentile: %d\n", perc50_3)
fprintf("25 percentile: %d\n", perc25_3)
fprintf("10 percentile: %d\n", perc10_3)
fprintf("cross covariance of step 1: %d\n", crossCov1_3)
fprintf("cross covariance of step 2: %d\n", crossCov2_3)
fprintf("cross covariance of step 3: %d\n", crossCov3_3)
fprintf("cross covariance of step 4: %d\n", crossCov4_3)

data4 = readmatrix("Data4.txt");
[m1_4, m2_4, m3_4, m4_4] = moments(data4);
[m2c_4, m3c_4, m4c_4] = moments_centered(data4);
[m3s_4, m4s_4] = moments_standardized(data4);
stdDev_4 = sqrt(m2c_4);
coeffVar_4 = stdDev_4/m1_4;
kurtosis_4 = m4s_4-3;
crossCov1_4 = cross_covariance(data4,1);
crossCov2_4 = cross_covariance(data4,2);
crossCov3_4 = cross_covariance(data4,3);
crossCov4_4 = cross_covariance(data4,4);
perc90_4    = perc_linInt(data4,90);
perc75_4    = perc_linInt(data4,75);
perc50_4    = perc_linInt(data4,50);
perc25_4    = perc_linInt(data4,25);
perc10_4    = perc_linInt(data4,10);

fprintf("\nTrace 4\n")
fprintf("first moment: %d\n", m1_4)
fprintf("second moment: %d\n", m2_4)
fprintf("third moment: %d\n", m3_4)
fprintf("fourth moment: %d\n", m4_4)
fprintf("second centered moment: %d\n", m2c_4)
fprintf("third centered moment: %d\n", m3c_4)
fprintf("fourth centered moment: %d\n", m4c_4)
fprintf("third standardized moment: %d\n", m3s_4)
fprintf("fourth standardized moment: %d\n", m4s_4)
fprintf("standard deviation: %d\n", stdDev_4)
fprintf("coefficient of variation: %d\n", coeffVar_4)
fprintf("kurtosys: %d\n", kurtosis_4)
fprintf("90 percentile: %d\n", perc90_4)
fprintf("75 percentile: %d\n", perc75_4)
fprintf("50 percentile: %d\n", perc50_4)
fprintf("25 percentile: %d\n", perc25_4)
fprintf("10 percentile: %d\n", perc10_4)
fprintf("cross covariance of step 1: %d\n", crossCov1_4)
fprintf("cross covariance of step 2: %d\n", crossCov2_4)
fprintf("cross covariance of step 3: %d\n", crossCov3_4)
fprintf("cross covariance of step 4: %d\n", crossCov4_4)

tiledlayout(2,2)

ax1=nexttile;
plot((sort(data1)), (1:length(data1))/length(data1));
title(ax1,'CDF data1');

ax2=nexttile;
plot((sort(data2)), (1:length(data2))/length(data2));
title(ax2,'CDF data2');

ax3=nexttile;
plot((sort(data3)), (1:length(data3))/length(data3));
title(ax3,'CDF data3');

ax4=nexttile;
plot((sort(data4)), (1:length(data4))/length(data4));
title(ax4,'CDF data4');

function [m1, m2, m3, m4] = moments(data)
    m1 = sum(data)/length(data);
    m2 = sum(data.^2)/length(data);
    m3 = sum(data.^3)/length(data);
    m4 = sum(data.^4)/length(data);
end

function [m2c, m3c, m4c] = moments_centered(data)
    mean = sum(data)/length(data);
    centered = data - mean;
    [~, m2c, m3c, m4c] = moments(centered);
end

function [m3s, m4s] = moments_standardized(data)
    mean = sum(data)/length(data);
    [stdev,~,~] = moments_centered(data);
    stdev = sqrt(stdev);
    centered = data - mean;
    standardized = centered ./ stdev;
    [~, ~, m3s, m4s] = moments(standardized);
end

function c = cross_covariance(data,lag)
    data = data-(sum(data)/length(data));
    lagged = [data(1:(end-lag)) data((lag+1):end)];
    newdata = lagged(:,1) .* lagged(:,2);
    c = mean(newdata);
end

function p = perc_linInt(data, percent)
    data=sort(data);
    h = (length(data)-1) * percent/100 +1;
    p=data(floor(h))+(h-floor(h))*(data(floor(h)+1) - data(floor(h)));
end
