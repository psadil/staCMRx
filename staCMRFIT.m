function [p, datafit, fits, maxbad, times] = staCMRFIT (nsample, data, model, E, shrink)
% function [p, datafit, fits] = staCMRFIT (nsample,data, model, E, shrink)
% multidimensional version of CMRfits. Replaces CMRfitsx.
% nsample = no. of Monte Carlo samples (about 10000 is good)
% data = data structure (cell array or general)
% model is a nvar * k matrix specifying the linear model; default = ones(nvar,1)
% E = optional partial order model e.g. E={[1 2] [3 4 5]} indicates that
% condition 1 <= condition 2 and condition 3 <= condition 4 <= condition 5
% shrink is parameter to control shrinkage of covariance matrix (if input is not stats form);
% 0 = no shrinkage; 1 = diagonal matrix; -1 = calculate optimum
% returns:
% p = empirical p-value
% datafit = observed fit of monotonic (1D) model
% fits = nsample vector of fits of Monte Carlo samples (it is against this
% distribution that datafit is compared to calculate p)
% *************************************************************************
% Last modified: 24 August 2016
% *************************************************************************
%
if ~iscell(data)
    y = gen2cell(data); % convert from general format
else
    y = data; % cell array format
end
nvar = size(y,2);
if nargin == 2
    model = ones(nvar,1); E={}; shrink = -1;
elseif nargin == 3;
    E={}; shrink = -1;
elseif nargin == 4
    shrink = -1;
end
if isempty(model)
    model = ones(nvar,1);
end
if isempty(shrink)
    shrink = -1;
end
if ~iscell(E)
    E = adj2cell(E); % convert from adjacency matrix form
end
[p, datafit, fits, maxbad, times] = jCMRfitsx(nsample,y, model, E, shrink, -1);
