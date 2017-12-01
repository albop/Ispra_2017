function indmcf = mcf_analysis(lpmat, ibeha, inobeha, options_mcf)
%
% function indmcf = mcf_analysis(lpmat, ibeha, inobeha, options_mcf)
%
% INPUTS
% lpmat:   MC sample matrix of parameters [nsample * nparams]
% ibeha:   array of indices for the behavioural samples, i.e.
%          lpmat(ibeha,:) produce behavioural output
% ibnoeha: array of indices for the behavioural samples, i.e.
%          lpmat(inobeha,:) produce NON-behavioural output
% options_mcf: structure of options (OPTIONAL)
%  fields of options_mcf are:
% 
% pvalue_ks: sets the p-value threshold for showing params (0.001)
% pvalue_corr: sets the p-value threshold for showing correlations (1.e-5)
% alpha2: sets minimum threshols for correlations (0)
% param_names: cell array of param names (CHAR)
%
% Written by Marco Ratto
% Joint Research Centre, The European Commission,
% marco.ratto@jrc.ec.europa.eu
%

% these options are not really triggered ...
% beha_title: identifier of behavioral set, shown in plots
% nobeha_title: identifier of non-behavioral set, shown in plots
% title: title of the plot
% amcf_name
% amcf_title
% options_mcf.fname_
% options_mcf.OutputDirectoryName


% Copyright (C) 2014 European Commission
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <http://www.gnu.org/licenses/>.

pvalue_ks = 0.001;
pvalue_corr = 1.e-5;
alpha2=0;
title = 'behaviour';
npar = size(lpmat,2);
for j=1:npar,
    if j>1,
        param_names = char(param_names,['X' int2str(j)]);
    else
        param_names = ['X' int2str(j)];
    end
end

if nargin>3,
    if isfield(options_mcf,'pvalue_ks')
        pvalue_ks = options_mcf.pvalue_ks;
    end
    if isfield(options_mcf,'pvalue_corr')
        pvalue_corr = options_mcf.pvalue_corr;
    end
    if isfield(options_mcf,'alpha2')
        alpha2 = options_mcf.alpha2;
    end
    if isfield(options_mcf,'param_names')
        param_names = options_mcf.param_names;
    end
    if isfield(options_mcf,'amcf_name')
        amcf_name = options_mcf.amcf_name;
    end
    if isfield(options_mcf,'amcf_title')
        amcf_title = options_mcf.amcf_title;
    end
    if isfield(options_mcf,'beha_title')
        beha_title = options_mcf.beha_title;
    end
    if isfield(options_mcf,'nobeha_title')
        nobeha_title = options_mcf.nobeha_title;
    end
    if isfield(options_mcf,'title')
        title = options_mcf.title;
    end
    if isfield(options_mcf,'fname_')
        fname_ = options_mcf.fname_;
    end
    if isfield(options_mcf,'OutputDirectoryName')
        OutputDirectoryName = options_mcf.OutputDirectoryName;
    end
end

[proba, dproba] = mcf_map_1(lpmat, ibeha, inobeha, 0);
%         indindet=find(dproba>ksstat);
indmcf=find(proba<pvalue_ks);
[tmp,jtmp] = sort(proba(indmcf),2,'ascend');
indmcf = indmcf(jtmp);
if ~isempty(indmcf)
    disp(['Smirnov statistics in driving ', title])
    for j=1:length(indmcf),
        disp([param_names(indmcf(j),:),'   d-stat = ', num2str(dproba(indmcf(j)),'%1.3f'),'   p-value = ', num2str(proba(indmcf(j)),'%1.3f')])
    end
    disp('')
end
if length(ibeha)>10 && length(inobeha)>10,
    indcorr1 = mcf_map_2(lpmat(ibeha,:),alpha2, pvalue_corr,0);
    indcorr2 = mcf_map_2(lpmat(inobeha,:),alpha2, pvalue_corr,0);
    indcorr = union(indcorr1(:), indcorr2(:));
    indcorr = indcorr(~ismember(indcorr(:),indmcf));
    indmcf = [indmcf(:); indcorr(:)];
end
if ~isempty(indmcf),
    disp('')
    scatter_mcf(lpmat(ibeha,indmcf),lpmat(inobeha,indmcf), param_names(indmcf,:))
end
