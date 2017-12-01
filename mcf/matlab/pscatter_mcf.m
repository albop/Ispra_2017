function  pscatter_mcf(X,Y,vnames,plotsymbol,diagonal)
% PURPOSE: Pairwise scatter plots of the columns of x
%---------------------------------------------------
% USAGE:    pscatter(x,vnames,pltsym,diagon)
%        or pscatter(x) which relies on defaults
% where:  
%        x = an nxk matrix with columns containing variables
%   vnames = a vector of variable names
%            (default = numeric labels 1,2,3 etc.)
%   pltsym = a plt symbol 
%            (default = '.' for npts > 100, 'o' for npts < 100 
%   diagon = 1 for upper triangle, 2 for lower triangle
%            (default = both upper and lower)
%---------------------------------------------------
% NOTE: uses function hist() 
%---------------------------------------------------

%       Anders Holtsberg, 14-12-94
%       Copyright (c) Anders Holtsberg
% JP LeSage added the vnames capability
% adapted by M. Ratto for Monte Carlo Filtering setting [Y data ADDED]

clf;
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

if nargin<5
   diagonal = 0;
end
if nargin<4 || isempty(plotsymbol)
   if n*p<100, plotsymbol = 'o';
   else plotsymbol = '.';
   end
end
bf = 0.1;
ffs = 0.05/(p-1);
ffl = (1-2*bf-0.05)/p;
fL = linspace(bf,1-bf+ffs,p+1);
for i = 1:p
   for j = 1:p
      if diagonal == 0 | (diagonal == 1 & j<=i) | (diagonal == 2 & j>=i)
         h = axes('position',[fL(i),fL(p+1-j),ffl,ffl]);
         if i==j
            h1=cumplot(X(:,j));
%             set(h1,'color',[0 0 1], 'linestyle','--','LineWidth',1.5)
            set(h1,'color',[0 0 1],'LineWidth',1.5)
            hold on,
            h2=cumplot(Y(:,j));
            set(h2,'color',[1 0 0],'LineWidth',1.5)
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
end