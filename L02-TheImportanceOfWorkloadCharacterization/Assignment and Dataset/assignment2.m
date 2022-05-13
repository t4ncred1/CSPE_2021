clearvars;

%read the data    
data1 = readmatrix("times_Log1.txt");
data2 = readmatrix("times_Log2.txt");
data3 = readmatrix("times_Log3.txt");
data4 = readmatrix("times_Log4.txt");

%normalize the data
data1=data1-min(data1);
data2=data2-min(data2);
data3=data3-min(data3);
data4=data4-min(data4);

%calculate the arrival rate, the inter arrival rates and the variances for
%each dataset.
[arrivalRate_1, inter_1, interRate_1, varInter_1] = calcRatesVar(data1);
[arrivalRate_2, inter_2, interRate_2, varInter_2] = calcRatesVar(data2);
[arrivalRate_3, inter_3, interRate_3, varInter_3] = calcRatesVar(data3);
[arrivalRate_4, inter_4, interRate_4, varInter_4] = calcRatesVar(data4);

%calculate the coefficient of variation on the arrival rate for each dataset
cv_1 = sqrt(varInter_1)/interRate_1;
cv_2 = sqrt(varInter_2)/interRate_2;
cv_3 = sqrt(varInter_3)/interRate_3;
cv_4 = sqrt(varInter_4)/interRate_4;

%calculate the 1-step correlation on the arrival rate for each dataset
corr_1 = cross_covariance(inter_1,1);
corr_2 = cross_covariance(inter_2,1);
corr_3 = cross_covariance(inter_3,1);
corr_4 = cross_covariance(inter_4,1);

fprintf("\nTrace 1\n")
fprintf("average Inter arrival time: %d\n", interRate_1)
fprintf("Arrival rate: %d\n", arrivalRate_1)
fprintf("Variability (C.v.): %d\n", cv_1)
fprintf("1 step correlation: %d\n", corr_1)

fprintf("\nTrace 2\n")
fprintf("average Inter arrival time: %d\n", interRate_2)
fprintf("Arrival rate: %d\n", arrivalRate_2)
fprintf("Variability (C.v.): %d\n", cv_2)
fprintf("1 step correlation: %d\n", corr_2)

fprintf("\nTrace 3\n")
fprintf("average Inter arrival time: %d\n", interRate_3)
fprintf("Arrival rate: %d\n", arrivalRate_3)
fprintf("Variability (C.v.): %d\n", cv_3)
fprintf("1 step correlation: %d\n", corr_3)

fprintf("\nTrace 4\n")
fprintf("average Inter arrival time: %d\n", interRate_4)
fprintf("Arrival rate: %d\n", arrivalRate_4)
fprintf("Variability (C.v.): %d\n", cv_4)
fprintf("1 step correlation: %d\n", corr_4)

%visualize the correlation between the data
tiledlayout(2,2)

ax1=nexttile;
scatter(ax1,inter_1(1:end-1),inter_1(2:end),'filled');
title(ax1,'Log1 plot');

ax2=nexttile;
scatter(ax2,inter_2(1:end-1),inter_2(2:end),'filled');
title(ax2,'Log2 plot');

ax3=nexttile;
scatter(ax3,inter_3(1:end-1),inter_3(2:end),'filled');
title(ax3,'Log3 plot');

ax4=nexttile;
scatter(ax4,inter_4(1:end-1),inter_4(2:end),'filled');
title(ax4,'Log4 plot');

function [arrival_rate, inter_arrivals, inter_arrival_rate, var_inter_arrivals] = calcRatesVar(data)

%total time
tot_time = max(data)-min(data);

%average arrival rate
arrival_rate = length(data)/tot_time;

%shift the data of 1
scaled_data = [0;data];
scaled_data = scaled_data(1:end-1,:);

%find the inter arrival times
inter_arrivals=data-scaled_data;
inter_arrivals(1,:)=[];

%average inter arrival rate
inter_arrival_rate = mean(inter_arrivals);

%variance of the inter arrival times
var_inter_arrivals = var(inter_arrivals);
end

function c = cross_covariance(data,lag)
    data = data-(sum(data)/length(data));
    lagged = [data(1:(end-lag)) data((lag+1):end)];
    newdata = lagged(:,1) .* lagged(:,2);
    c = mean(newdata);
end
