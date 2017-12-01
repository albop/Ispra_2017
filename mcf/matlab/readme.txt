% Monte Carlo Filtering stadalone toolkit
%
% Written by Marco Ratto
% Joint Research Centre, The European Commission,
% marco.ratto@jrc.ec.europa.eu
%
% Copyright (C) 2005 European Commission
%
%the main interface is
%indmcf = mcf_analysis(lpmat, ibeha, inobeha, options_mcf);

% small example

x = randn(250, 8);

y = x(:,1)+x(:,2).^2 + x(:,1).*x(:,2);

ibeha=find(y<0);
ino=find(y>=0);
%opts.param_names=bayestopt_.name;
inx=mcf_analysis(x, ibeha, ino);

x1=-0.5
x2=0.5;
yn = x1+x2.^2 + x1.*x2
