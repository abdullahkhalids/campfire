function [n,ys1] = polydeg(x,y)

%POLYDEG Optimal polynomial fitting.
%   N = POLYDEG(X,Y) yields the optimal degree N for polynomial fitting of
%   the data Y(X). The degree N is determined by minimizing the Akaike's
%   information criterion.
%
%   [N,YI] = POLYDEG(X,Y) also returns the fitted data YI.
%
%   Least-square curve fitting using polynomials is the most basic way to
%   perform a parametric regression analysis. Assume that you have some
%   data points through which you want to pass a fitting polynomial. The
%   obvious question for some to ask is which degree to choose. A linear or
%   first degree polynomial approximation might represent your data very
%   poorly. On the other side, a very high order polynomial, say 30, could
%   result in an excessively complex model (overfitting). Clearly, a
%   compromise must be made between the precision and the complexity of the
%   polynomial model. Akaike's information criterion (AIC), developed by
%   Hirotsugu Akaike can be used as a measure of the goodness of fit.
%
%   The <a
%   href="matlab:web('http://en.wikipedia.org/wiki/Akaike_Information_Criterion')">AIC</a> describes the tradeoff between the accuracy and complexity of a
%   model. For a polynomial of degree N (i.e. N+1 parameters) the Akaike's
%   information criterion is defined by:
%           AIC = 2*(N+1) + n*(log(2*pi*RSS/n)+1),
%   where n is the number of points and RSS is the residual sum of squares.
%   The optimal degree is defined as the degree N which minimizes <a
%   href="matlab:web('http://en.wikipedia.org/wiki/Akaike_Information_Criterion')">AIC</a>.
%
%   Examples:
%   --------
%   load census
%   [n,popi] = polydeg(cdate,pop);
%   plot(cdate,pop,'o',cdate,popi)
%   title(['Optimal degree: ' int2str(n)])
%
%   x = linspace(0,10,1000);
%   y = sin(x.^3/100).^2 + 0.05*randn(size(x));
%   [n,yi] = polydeg(x,y);
%   plot(x,y,'.',x,yi,'r','LineWidth',2)
%   title(['Optimal degree: ' int2str(n)])
%
%   See also POLYFIT, ORTHOFIT.
%
%   -- Damien Garcia -- 02/2008, revised 12/2010
%   website: <a
%   href="matlab:web('http://www.biomecardio.com')">www.BiomeCardio.com</a>


%% Check input arguments
% ---
%
error(nargchk(2,2,nargin));

siz = size(x);
x = x(:);
y = y(:);
N = length(x);

if ~isequal(N,length(y))
    error('MATLAB:polydeg:XYNumelMismatch',...
          'X and Y must have same number of elements.')
elseif ~isfloat(x) || ~isfloat(y)
    error('MATLAB:polydeg:NonFloatingXY',...
    'X and Y must be floating point arrays.')
end

%% Search the optimal degree minimizing the Akaike's information criterion
% ---
%  y(x) are fitted in a least-squares sense using a polynomial of degree n
%  developed in a series of orthogonal polynomials.
%

% Turn warning messages off
warn01 = warning('query','MATLAB:log:logOfZero');
warn02 = warning('query','MATLAB:divideByZero');
warning('off','MATLAB:log:logOfZero')
warning('off','MATLAB:divideByZero')

% 0th order
p = mean(y);
ys = ones(N,1)*p;
AIC = 2+N*(log(2*pi*sum((ys-y).^2)/N)+1)+...
    4/(N-2);  % correction for small sample sizes

p = zeros(2,2);
p(1,2) = mean(x);
PL = ones(N,2);
PL(:,2) = x-p(1,2);

n = 1;
nit = 0;
if nargout==2, [ys1,ys2,ys3,ys4] = deal(ys); end

% While-loop is stopped when a minimum is detected. 3 more steps are
% required to take AIC noise into account and to ensure that this minimum
% is a (likely) global minimum.
% ---
while nit<3
    
    % -- Orthogonal polynomial fitting (see also ORTHOFIT)
    if n>1
        p(1,n+1) = sum(x.*PL(:,n).^2)/sum(PL(:,n).^2);
        p(2,n+1) = sum(x.*PL(:,n-1).*PL(:,n))/sum(PL(:,n-1).^2);
        PL(:,n+1) = (x-p(1,n+1)).*PL(:,n)-p(2,n+1)*PL(:,n-1);
    end
    
    tmp = sum(bsxfun(@times,y,PL))./sum(PL.^2);
    ys = sum(bsxfun(@times,PL,tmp),2);
    
    % -- Akaike's Information Criterion
    aic = 2*(n+1)+N*(log(2*pi*sum((ys-y(:)).^2)/N)+1)+...
        2*(n+1)*(n+2)/(N-n-2); % correction for small sample sizes
    
    if aic>=AIC
        nit = nit+1;
    else
        nit = 0;
        AIC = aic;
    end
    n = n+1;
    
    if nargout==2, ys1 = ys2; ys2 = ys3; ys3 = ys4; ys4 = ys; end
    if n>=N, ys1 = ys; break, end
    
end

n = n-nit-1;

if nargout==2, ys1 = reshape(ys1,siz); end

% Go back to previous warning states
warning(warn01)
warning(warn02)

