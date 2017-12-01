function  scatter_mcf(X,Y,vnames,plotsymbol, xparam1, beha_name, non_beha_name)

% PURPOSE: Pairwise scatter plots of the columns of x and y after
% Monte Carlo filtering
%---------------------------------------------------
% USAGE:    scatter_mcf(x,y,vnames,pltsym,diagon)
%        or scatter_mcf(x,y) which relies on defaults
% where:
%        x = an nxk matrix with columns containing behavioural sample
%        y = an mxk matrix with columns containing non-behavioural sample
%   vnames = a vector of variable names
%            (default = numeric labels 1,2,3 etc.)
%   pltsym = a plt symbol
%            (default = '.' for npts > 100, 'o' for npts < 100
% 
% Written by Marco Ratto
% Joint Research Centre, The European Commission,
% marco.ratto@jrc.ec.europa.eu
%

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



Z=[X;Y];
[n,p] = size(X);
% X = X - ones(n,1)*min(Z);
% X = X ./ (ones(n,1)*max(Z));
[n,p] = size(Y);
% Y = Y - ones(n,1)*min(Z);
% Y = Y ./ (ones(n,1)*max(Z));
[n,p] = size(Z);
clear Z;

nflag = 0;
if nargin >=3
    nflag = 1;
end;

if nargin<4 || isempty(plotsymbol)
    if n*p<100, plotsymbol = 'o';
    else plotsymbol = '.';
    end
end

if nargin<5,
  xparam1=[];
end
if nargin<6,
  beha_name = 'BEHAVIOUR';
  non_beha_name = 'NON-BEHAVIOUR';
end
if nargin==7,
  non_beha_name = ['NON-' beha_name];
end

figure,

bf = 0.1;
ffs = 0.05/(p-1);
ffl = (1-2*bf-0.05)/p;
if p>1,
    fL = linspace(bf,1-bf+ffs,p+1);
else
    fL = bf;
end
for i = 1:p
    for j = 1:p
        h = axes('position',[fL(i),fL(p+1-j),ffl,ffl]);
        if i==j
            h1=cumplot(X(:,j));
            %             set(h1,'color',[0 0 1], 'linestyle','--','LineWidth',1.5)
            set(h1,'color',[0 0 1],'LineWidth',1.5)
            hold on,
            h2=cumplot(Y(:,j));
            set(h2,'color',[1 0 0],'LineWidth',1.5)
            if ~isempty(xparam1)
                hold on, plot(xparam1([j j]),[0 1],'k--')
            end
            if j<p
                set(gca,'XTickLabel',[],'XTick',[]);
            else
                grid off
            end
            set(gca,'YTickLabel',[],'YTick',[]);
        else
            if j>i
                plot(X(:,i),X(:,j),[plotsymbol,'b'])
                hold on,
                plot(Y(:,i),Y(:,j),[plotsymbol,'r'])
            else
                plot(Y(:,i),Y(:,j),[plotsymbol,'r'])
                hold on,
                plot(X(:,i),X(:,j),[plotsymbol,'b'])
            end
            if ~isempty(xparam1)
                hold on, plot(xparam1(i),xparam1(j),'k*')
            end
            hold off;
            %             axis([-0.1 1.1 -0.1 1.1])
            if i<p,
                set(gca,'YTickLabel',[],'YTick',[]);
            else
                set(gca,'yaxislocation','right');
            end
            if j<p
                set(gca,'XTickLabel',[],'XTick',[]);
            end
        end
        if nflag == 1
            set(gca,'fontsize',9);
        end;
        if i==1
            if nflag == 1
                ylabel(vnames(j,:),'Rotation',45,'interpreter','none', ...
                    'HorizontalAlignment','right','VerticalAlignment','middle');
            else
                ylabel([num2str(j),' '],'Rotation',90)
            end;
        end
        if j==1
            if nflag == 1
                title(vnames(i,:),'interpreter','none','Rotation',45, ...
                    'HorizontalAlignment','left','VerticalAlignment','bottom')
            else
                title(num2str(i))
            end;
        end
        drawnow
    end
end

annotation('textbox', [0.1,0,0.35,0.05],'String', beha_name,'Color','Blue','horizontalalignment','center','interpreter','none');
annotation('textbox', [0.55,0,0.35,0.05],'String', non_beha_name,'Color','Red','horizontalalignment','center','interpreter','none');
