function h = cumplot(x);
%function h =cumplot(x)
% cumulative probaboloty plot of a sample x
% 
% Written by Marco Ratto
% Joint Research Centre, The European Commission,
% marco.ratto@jrc.ec.europa.eu
%
% Copyright (C) 2005 European Commission


n=length(x);
x=[-inf; sort(x); Inf];
y=[0:n n]./n;
h0 = stairs(x,y);
%grid on,

if nargout,
    h=h0;
end
