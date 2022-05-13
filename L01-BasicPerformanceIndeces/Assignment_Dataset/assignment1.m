data = readmatrix("DataSet2.csv");
time = max(data(:,2));

arrival_rate = length(data(:,1)) / time;

throughput = length(data(:,2)) / time;

busy_time = data(1,2)-data(1,1);
for i = 2:size(data,1)
    if(data(i,1) > data(i-1,2))
        busy_time = busy_time + data(i,2)-data(i,1);
    else 
        busy_time = busy_time + data(i,2)-data(i-1,2);
    end
end

avg_service_time = busy_time / length(data(:,2));

utilization = throughput * avg_service_time;

response_times = data(:,2)-data(:,1);

avg_response_time = mean(response_times);

W = sum(response_times);

avg_num_jobs = throughput * avg_response_time;

fprintf("Arrival rate:\t\t%d\n", arrival_rate);
fprintf("Busy time:\t\t%d\n",busy_time);
fprintf("Utilization:\t\t%d\n", utilization);
fprintf("W:\t\t\t%d\n",W);
fprintf("Average service time:\t%d\n",avg_service_time);
fprintf("Average number of jobs:\t%d\n",avg_num_jobs);
fprintf("Average response time:\t%d\n",avg_response_time);

