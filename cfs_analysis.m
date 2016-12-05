% analysis script to run

% ugh, first need all folders and subfolders to be available
addpath(genpath('D:\git\staCMRx'));

% next, need to make java runtime libraries available to matlab
javaclasspath('D:\git\staCMRx\java\fxMR-0.3.18.jar');

% load data, from CFS
% NOTE: seems like the full dataset indicates two processes, but not when
% CFS trials are trimmed by PAS!
% d = load('data_staCMRx_.csv');
d = load('data_trim_staCMRx_.csv');

% convert to cell array format
y = gen2cell(d);

% checkout simple stats
dstats = staSTATS(y, 0);

% note: resulting structure should be of length two, one structure for each
% of the different independent variables

% perform CMR
[x1, f1, s1] = staCMRx (d, [], []);

% estimate empirical distribution and p-values of the fit
[p, datafit, fits] = staCMRFIT(10000, d, [], []);

% checkout
disp([p, datafit])
histogram (fits, 100)

% plot structure
staPLOT(d, ...
    'pred', x1, ...
    'labels', {'Group 1'}, ...
    'axislabels', {'2AFC' 'Name'});
