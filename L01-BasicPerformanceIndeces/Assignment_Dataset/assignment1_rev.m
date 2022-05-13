clearvars;
global data response_times;
data = readmatrix("DataSet1.csv");
response_times = data(:,2)-data(:,1);
tot_time = max(data(:,2));

busy_time = data(1,2)-data(1,1);

for i = 2:size(data,1)
    if(data(i,1) > data(i-1,2))
        busy_time = busy_time + data(i,2)-data(i,1);
    else 
        busy_time = busy_time + data(i,2)-data(i-1,2);
    end
end

avg_response_time = mean(response_times);

throughput = C(tot_time)/tot_time;

arrival_rate = A(tot_time)/tot_time;

avg_service_time = busy_time / C(tot_time);

utilization = throughput * avg_service_time;

W = sum(response_times);

W_alt = integral((@(x) A(x)-C(x)),0,tot_time);

avg_num_jobs = throughput * avg_response_time; %% Little's law
avg_num_jobs_alt = W/tot_time;

avg_response_time_alt = W/C(tot_time);
test = integral((@(x)double(N(x)>0)),0,tot_time);

fprintf("Arrival rate:\t\t\t\t\t%d\n", arrival_rate);
fprintf("Throughput:\t\t\t\t\t%d\n", throughput);
fprintf("Busy time:\t\t\t\t\t%d\n",busy_time);
fprintf("Utilization:\t\t\t\t\t%d\n", utilization);
fprintf("W:\t\t\t\t\t\t%d\n",W);
fprintf("Average service time:\t\t\t\t%d\n",avg_service_time);
fprintf("Average number of jobs:\t\t\t\t%d\n",avg_num_jobs);
fprintf("Average response time:\t\t\t\t%d\n",avg_response_time);
fprintf("Probability of a response time less than 1:\t%d\n",response_time_distribution(1));
fprintf("Probability of a response time less than 10:\t%d\n",response_time_distribution(10));
fprintf("Probability of a response time less than 50:\t%d\n",response_time_distribution(50));
fprintf("Probability of having 0 jobs in the station:\t%d\n",Pn_alt(0,tot_time));
fprintf("Probability of having 1 job in the station:\t%d\n",Pn_alt(1,tot_time));
fprintf("Probability of having 2 jobs in the station:\t%d\n",Pn_alt(2,tot_time));
fprintf("Probability of having 3 jobs in the station:\t%d\n",Pn_alt(3,tot_time));

%This is the alternative approach to compute the probabilities of 
% the sistem having a certain number of jobs.
% This method works, but it's imprecise (I guess due to rounding)
function ym = Y(m,T)
    ym = integral((@(x)double(N(x) == m)),0,T);
end

function pn_alt = Pn_alt(m,T)
    global data;
    set = data(1:end, :);
    jobs = [set(:,1) ones(length(set(:,1)),1);
            set(:,2) (zeros(length(set(:,2)),1) - 1)];
    jobs = sortrows(jobs);
    jobs = [jobs(:,1) cumsum(jobs(:,2))];
    jobs = [0 0; jobs];
    jobs = [jobs(2:end,1)-jobs(1:end-1,1) jobs(1:end-1, 2)]
    
    tot = sum(jobs(jobs(:,2) == m));
    pn_alt = tot/T;
end

function n = N(time)
    n = A(time)-C(time);
end

function c = C(time)
    global data;
    c = sum(data(:,2) <= time);
end

function a = A(time)
    global data;
    a = sum(data(:,1) <= time);
end

function r = response_time_distribution(threshold)
    global response_times;
    r = sum(response_times <threshold)/length(response_times);
end