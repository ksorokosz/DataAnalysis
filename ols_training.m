% Function computes regression model (ordinary least squares)
% using normal equation: inv(X'*X)*X'*y
% first column of the data (x0) should be 1

function [theta] = ols_training(data, output)

theta = pinv(transpose(data)*data)*transpose(data)*output; % normal equation
