function [proba, dproba, ddstat] = mcf_map_k(lpmat, y, k, ifig)
%function [proba, dproba, ddstat] = mcf_map_1(lpmat, y, ifig)
%
% lpmat =  Monte Carlo matrix
% y  = output matrix
% k  = n. of bins to separate y
% ifig = 1 plot cumulative distributions (default)
% ifig = 0 no plots
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



if nargin<3 | isempty(k),
  k=10;
end
if nargin<4 | isempty(ifig),
  ifig=1;
end

npar=size(lpmat,2);
nrun=size(lpmat,1);
if length(y)~= nrun
  disp('Error! The input and output data must have the same length')
  return
end

[ys, is]=sort(y);
nb=round(nrun/k);


% Smirnov test; 
for j=1:npar,
  x=lpmat(:,j);
  bin = [-inf ; sort(x) ; inf];

  xlab{j}=['X',int2str(j)];
  if ifig
    if mod(j,12)==1
      figure,
      c=colormap(jet(k));
      iplot=0;
    end
    iplot=iplot+1;
    subplot(3,4,iplot), hold on, set(gca,'box','on')
  end
  for kk=1:k
    if kk==k
      ib = is(1+nb*(kk-1):end);
      in = is(1:nb*(kk-1));
    else
      ib = is(1+nb*(kk-1):nb*kk);
      in = is(find(~ismember([1:nrun],[1+nb*(kk-1):nb*kk])));
    end
    [H,P,KSSTAT] = smirnov(lpmat(ib,j),lpmat(in,j));
    proba(j,kk)=P;
    dproba(j,kk)=KSSTAT;
    ncount = histc (lpmat(ib,j) , bin);

    cum1  =  cumsum(ncount)./sum(ncount);
    cum(:,kk)  =  cum1(1:end-1);
    ddstat(j) = max(max(cum')-min(cum'));

    
    if ifig
      if ~isempty(ib),
        h=cumplot(lpmat(ib,j));
        set(h,'color',c(kk,:))
      end
      title(['X_',int2str(j)],'interpreter','none')
    end
  end
end

figure, 
subplot(211), bar([mean(dproba')' std(dproba')']), 
set(gca, 'xticklabel', xlab)
legend('ave(d-stat)','std(d-stat)',0)
%subplot(212), bar(-log10(min(proba')./0.01)), 
%legend('-log(prob/0.01)',0)
subplot(212), bar(ddstat), 
set(gca, 'xticklabel', xlab)
legend('dd-stat',0)


