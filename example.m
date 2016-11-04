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

% distribution (b, c)
sample = data(:, 168);

figure
title 'data with positive skew'
subplot(2,1,1)
hist(sample)   % positive skew
title 'positive skew'
subplot(2,1,2)
hist(log10(sample)) % like normal distribution
title 'quite normal ;)'
print(gcf, 'distributions.png', '-dpng');

% outliers (d)







