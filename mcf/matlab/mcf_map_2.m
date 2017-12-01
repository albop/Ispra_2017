function indcorr = mcf_map_2(x,alpha2,pvalue_crit,plots)
% function mcf_map_2(x,alpha2)
%
%
% Written by Marco Ratto
% Joint Research Centre, The European Commission,
% marco.ratto@jrc.ec.europa.eu
%
% Copyright (C) 2005 European Commission
%

if nargin<4,
    plots=1;
end

npar=size(x,2);
if nargin==1,
    alpha2=0.4;
end

[c0, pvalue] = corrcoef(x);
c00=tril(c0,-1);

ifig=0;
j2=0;
indcorr = [];
for j=1:npar,
    i2=find(abs(c00(:,j))>alpha2);
    if length(i2)>0,
        for jx=1:length(i2),
            if pvalue(j,i2(jx))<pvalue_crit,
                indcorr = [indcorr; [j i2(jx)]];
                if plots,
                j2=j2+1;
                if mod(j2,12)==1,
                    ifig=ifig+1;
                    figure,
                end
                subplot(3,4,j2-(ifig-1)*12)
                plot(x(:,j),x(:,i2(jx)),'.')
                xlabel(['X_',int2str(j)])
                ylabel(['X_',int2str(i2(jx))])
                title(['cc = ',num2str(c0(i2(jx),j))])
                end
            end
        end
    end
    
end
if ifig==0 && plots,
    disp(['No correlation term >', num2str(alpha2),' found.'])
end
%close all
