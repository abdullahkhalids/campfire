close all;

constants;
hold on;
f= 0.2 ; %trough.focalLength;

x = 0:0.01:1;

s = (2*f)./sqrt(x.^2 + 4*f^2);

theta = acosd(s);

n = 1.65; %1.26232 + 7.1855i;
thetaT = snellLaw(deg2rad(theta),1,n);

plot(x,theta)

R = frenelReflectionCoefficient(deg2rad(theta),deg2rad(thetaT),1,n,'s');
figure;
plot(x,R);

mean(R)

