
clearvars;
data = readmatrix("DataSet1.csv");
total_time = max(data(:,2));

response_times = data(:,2)-data(:,1);

%Arrival rate and throughput

arrival_rate = length(data(:,1))/total_time;
throughput = length(data(:,2))/total_time;

%Average response time

avg_resp_time = mean(response_times);

%Average number of jobs in the system
arrivals    = [data(:,1) ones(length(data(:,1)),1)];
completions = [data(:,2) (zeros(length(data(:,2)),1) - 1)];

jobs = sortrows([arrivals;completions]);
jobs = [jobs(:,1) cumsum(jobs(:,2))];

avg_number_jobs = mean(jobs(:,2));

% Queue lenght distribution


