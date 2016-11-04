% Script analyse the data about video popularity
% and implements an algorithm that predicts the future popularity
% Created on: GNU Octave, version 3.2.4

rawdata = csvread('data.csv');
data = rawdata(:, 2:end); % remove labels from the set

% basic statistics (a)
ids = [ 24, 72, 168 ];

basic_statistics = zeros(length(ids), 3);
for i = 1 : length(ids)
	id = ids(i);
	avg = mean(data(:, id)); 
	dev = std(data(:, id));
	% what else may be called basic statistics?

	basic_statistics(i, 1) = id;
	basic_statistics(i, 2) = avg;
	basic_statistics(i, 3) = dev;
end

csvwrite('basic_statistics.csv', basic_statistics);
sample = data(:, 168);
logsample = log10(sample);

% distribution (b, c)
figure(1)
subplot(2,1,1)
hist(sample)   % positive skew
title 'positive skew'
subplot(2,1,2)
hist(logsample) % like normal distribution
title 'quite normal ;)'
print(gcf, 'distributions.png', '-dpng');

% outliers (d)
avg = mean(logsample);
dev = std(logsample);

not_outliers = and( logsample <= avg + 3*dev, logsample >= avg - 3*dev );
figure(2)
subplot(2,1,1)
hist(log10(sample))
title 'with outliers'
subplot(2,1,2)
hist(log10(sample(not_outliers)))
title 'without outliers'
print(gcf, 'outliers.png', '-dpng');

% remove outliers from the data
data = data(not_outliers, :);
sample = sample(not_outliers);
logdata = log10(data + eps); % data(:,1) contains zeros log(zeros) = -inf so I have add eps to the data 
logsample = log10(sample);

% pearson coefficient (e)
coeffs = zeros(1,24);
for n = 1 : 24
	coeffs(n) = corrcoef(logdata(:,n), logsample);
end
csvwrite('correlation.csv', coeffs); 


