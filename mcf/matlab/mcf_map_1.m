function [proba, dproba] = mcf_map_1(lpmat, ibehaviour, inonbehaviour, iplot)
%function [proba, dproba] = mcf_map_1(lpmat, ibehaviour, inonbehaviour, iplot)
%
% lpmat =  Monte Carlo matrix
% ibehaviour = index of behavioural runs
% inonbehaviour = index of non-behavioural runs
% iplot = 1 plot cumulative distributions (default)
% iplot = 0 no plots
% Plots: dotted lines for BEHAVIOURAL
%        solid lines for NON BEHAVIOURAL
% USES smirnov
%
% Written by Marco Ratto
% Joint Research Centre, The European Commission,
% marco.ratto@jrc.ec.europa.eu
%
% Copyright (C) 2005 European Commission
%



if nargin<4,
  iplot=1;
end

npar=size(lpmat,2);


% Smirnov test; 
for j=1:npar,
  [H,P,KSSTAT] = smirnov(lpmat(ibehaviour,j),lpmat(inonbehaviour,j));
  proba(j)=P;
  dproba(j)=KSSTAT;
end
if iplot
  
for i=1:ceil(npar/12),
  figure,
  for j=1+12*(i-1):min(npar,12*i),
    subplot(3,4,j-12*(i-1))
    if ~isempty(ibehaviour),
      h=cumplot(lpmat(ibehaviour,j));
      set(h,'color',[0 0 0], 'linestyle',':')
    end
    hold on,
    if ~isempty(inonbehaviour),
      h=cumplot(lpmat(inonbehaviour,j));
      set(h,'color',[0 0 0])
    end
    title(['X_',int2str(j),'. D-stat ', num2str(dproba(j),2)],'interpreter','none')
  end
end
end
