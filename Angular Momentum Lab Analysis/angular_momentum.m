% Authors: Matthew Betchel, Rishab Pally, Tristan Seeley
%LAB A2
close all 
clear
clc

mass= 2.98;
%unit conversions to cm to meters
diameter= (33E-2)*2;
x_position= .1778;
gravity_constant=9.81;

Inertia_1= 0.5*mass*(diameter/2)^2;
Inertia_3= mass*(diameter/2)^2 +mass*x_position^2; 

%Unit conversion %km/h to m/s
vt= [20, 21.5, 29.5, 30, 38]'.*0.277778;
w3= vt./(diameter/2);


I= [Inertia_1,0,0;0,Inertia_3,0;0,0,Inertia_3];
H3= Inertia_3*w3;
P= (mass*-gravity_constant*x_position)./(H3);

torque= mass*-gravity_constant*x_position;

Torque_v= ((2*pi)./P);


T_matrix= [-3.91, -4.05, -5.56, -6.62, -6.92]; %[s]
P_matrix= (2*pi)./T_matrix;

P_zero= zeros(1,5);
T_zero= zeros(1,5);
for i=1:5
    
    P_zero(i)= ((P_matrix(i)-P(i))./P(i))*100;
    T_zero(i)= (T_matrix(i)-Torque_v(i))./Torque_v(i);
end
P
P_matrix

figure
plot(w3,P)
hold on
xlabel('Angular Velocity[rad/s]')
ylabel('Precession Rate[rad/s]')
title('Precession vs. Angular Velocity')
plot(w3,P_matrix)
hold off
legend('Predicted','Experimental','location','northwest')

figure
plot(w3,-1*Torque_v)
hold on
xlabel('Angular Velocity[rad/s]')
ylabel('Period[s]')
title('Period vs. Angular Velocity')
plot(w3,-1*T_matrix)
hold off
legend('Predicted','Experimental','location','northwest')
