% x = 100:400;
% p1 = -0.00016656;
%   p2 = 0.038493;
%   p3 = 69.035;
% 
% y = p1*x.^2 + p2*x +   p3 ;
% 
%  p1 = -0.00011084
%   p2 = -0.0034573
%   p3 = 69.763
%   y2 = p1*x.^2 + p2*x +  p3 ;
% hold on
% plot(x,y2,'r-')
% plot(x,y)
 
x = 50:350;
  p1 = -0.00014732;
  p2 = 0.024865;
  p3 = 69.835;

y = p1*x.^2 + p2*x +  p3 ;

  p1 = -0.00020078;
  p2 = 0.035849;
  p3 = 66.899;

y2 = p1*x.^2 + p2*x +   p3 ;

hold on
plot(x,y2,'g-')
plot(x,y,'k-')

legend('SEGS data Vacuum','SEGS data Air', 'Model prediction Vacuum', 'Model prediction Air')
 