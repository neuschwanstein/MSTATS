%% Main script

%% Import csv from yahoo finance
url = 'http://real-chart.finance.yahoo.com/table.csv?s=%5EOEX&a=00&b=2&c=1986&d=11&e=15&f=1989&g=d&ignore=.csv';
filename = 'prices.csv';
urlwrite(url, filename);
prices = csvread(filename,1,4); % This line and the following: take the offset of the 'close' column in the csv.
prices = prices(:,1);
prices = flipupd(prices);
X = log(prices(2:end)./prices(1:end-1));

%% Estimate parameters
[lambda,a0,a1,b1] = findGarchParameters(X);

%% Generate Duan tables
% [price,delta] = duanTables(lambda,a0,a1,b1);
[price,delta] = duanTables(7.452e-3,1.524e-5,0.1883,0.7162);

%% And output them to latex file
tableGeneration(price,delta);