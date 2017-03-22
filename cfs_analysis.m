% analysis script to run
% NOTE: seems like the full dataset indicates two processes, but not when
% CFS trials are trimmed by PAS!

% ugh, first need all folders and subfolders to be available
cd('D:\git\staCMRx')
if ~exist('./figs', 'dir'),
    mkdir('./figs');
end
addpath(genpath(pwd));

% next, need to make java runtime libraries available to matlab
javaclasspath('.\java\fxMR-0.3.18.jar');

%% load data, from CFS
d = load('data_trim_staCMRx_.csv');

% estimate empirical distribution and p-values of the fit
[p, datafit, fits] = staCMRFIT(10000, d);

% perform CMR
[x1, f1, s1] = staCMRx(d);

% plot structure
f = figure();
staPLOT(d, ...
    'pred', x1, ...
    'labels', {'Group 1'}, ...
    'axislabels', {'2AFC' 'Name'});
saveas(f, './figs/trim','png');
savefig('./figs/trim');


%% now again, with full dataset
d = load('data_staCMRx_.csv');
[p, datafit, fits] = staCMRFIT(10000, d);

% perform CMR
[x1, f1, s1] = staCMRx(d);

% plot structure
f = figure();
staPLOT2(d, ...
    'pred', x1, ...
    'groups', [{1},{2},{3},{4}], ...
    'labels', {'Not Studied', 'Word', 'CFS', 'Binocular'}, ...
    'axislabels', {'2AFC' 'Name'})
xlim([.3,1])
ylim([.3,1])
ax = gca;
ax.XTick = [.3,1];
ax.YTick = [.3,1];
ax.PlotBoxAspectRatio = [1,1,1];
ax.LineWidth = 3;
ax.Box = 'off';
ax.DataAspectRatio = [1,1,1];
ax.FontSize=30;
ax.FontName = 'Arial';
f.Units = 'inches';
f.PaperSize = [6,6];
f.Position = [0,0,6,6];


saveas(f, './figs/full','png');
savefig('./figs/full');


%% extras

% convert to cell array format
y = gen2cell(d);

% checkout simple stats
dstats = staSTATS(y, 0);

% note: resulting structure should be of length two, one structure for each
% of the different independent variables

% perform regular MR
[x2, f2, s2] = staMR(d, [], 0); 
% NOTE: with empty E, the observed fit (i.e., least squared error) will
% always be 0 for regularly Monotonic Regression


% checkout
disp([p, datafit])
histogram (fits, 100)
