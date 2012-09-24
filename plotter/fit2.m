x = 50:350;  
p1 = 0.0007665
  p2 = 0.020303
  p3 = 1.5612

y = p1*x.^2 + p2*x +     p3; 

 p1 = 0.0009726
  p2 = 0.073288
  p3 = 13.553
y2 = p1*x.^2 + p2*x +    p3 ;

hold on
plot(x,y2,'r-')
plot(x,y,'k-')

legend('SEGS data Vacuum','SEGS data Air', 'Model prediction Vacuum', 'Model prediction Air')
 
 