function scatter_1(lpmat, y, pnam, nplo, ptslbl, ptscol)
%function scatter_1(lpmat, y)
%
% lpmat =  Monte Carlo matrix
% y = output values
%
% Written by Marco Ratto
% Joint Research Centre, The European Commission,
% marco.ratto@jrc.ec.europa.eu
%
% Copyright (C) 2005 European Commission
%


if nargin==0,
   disp('scatter_1(lpmat, y)')
   return
end
npar=size(lpmat,2);
if nargin<4,
  nplo=min(npar,12);
end

nrow = floor(sqrt(nplo));
ncol = nrow+1;
if ncol*nrow<nplo, nrow=nrow+1; end
% Smirnov test; 
for i=1:ceil(npar/nplo),
  figure,
  for j=1+nplo*(i-1):min(npar,nplo*i),
    subplot(nrow,ncol,j-nplo*(i-1))
    plot(lpmat(:,j),y,'.')
    if nargin >= 5,
    for ip=1:length(ptslbl)
      if nargin==6
        text(lpmat(ip,j),y(ip),ptslbl{ip},'units','data','fontsize',8,'color',ptscol(ip))
      else
        text(lpmat(ip,j),y(ip),ptslbl{ip},'units','data','fontsize',8)
      end
    end
    end
    if nargin==2,
      title(['X_',int2str(j)],'interpreter','none')
    else
      title(pnam{j},'interpreter','none','fontsize',12)
    end
  end
end
