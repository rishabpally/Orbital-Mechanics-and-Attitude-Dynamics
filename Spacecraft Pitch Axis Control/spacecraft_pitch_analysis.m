% Analysis 2
clc;clear;close all;

kp = 85.4931 ;

t = linspace(0,6);
w_n = sqrt(kp);
z =  0.5911;


num = [1];
den = [1 29.9194 85.4931];
systf = tf(num,den);


[beta1, t1] = step(systf);

s1 = -z.*w_n+((w_n).*sqrt(z.^2-1));
s2 = -z.*w_n-((w_n).*sqrt(z.^2-1));
S = [s1;s2]

figure()
plot(t1,beta1,"-k");
title('Predicted Response')
grid on
xlabel('Time (sec)')
ylabel('Postion (rad)')
%saveas(gcf,"Predicted_Response.png")








%% Analysis 3


%% Experimental Design

T1 = readmatrix("tested_gains1");
T2 = readmatrix("tested_gains2");

t1 = T1(:,1)/1000 - T1(1,1)/1000; %% Converts ms to sec
ref_pos1 = T1(:,2); % Position in radians
mes_pos1 = T1(:,3);
mes_p1 = mes_pos1 - T1(1,3); %% If perfect response
Torque_1 = T1(:,4)*33.5;

figure()
% subplot(2,1,1)
plot(t1, ref_pos1);
grid on
hold on 
plot(t1, mes_pos1);
xline(5.53,'-r', {'1.5-sec'})
yline(0.55,'-m', {'10% overshoot'})
yline(0.475,'-k', {'5% settle time'})
yline(0.525,'-k', {'5% settle time'})
legend("Refrence Positon", "Measured Position", "1.5-sec","10% overshoot","5% settle time","5% settle time");
title("Test 1")
xlabel('Time (sec)')
ylabel("Positon (rad)")
% saveas(gcf,"Fig_1_Test1.png")

figure()
plot(t1, ref_pos1);
grid on
hold on 
plot(t1, mes_p1);
xline(5.53,'-r', {'1.5-sec'})
yline(0.55,'-m', {'10% overshoot'})
yline(0.475,'-k', {'5% settle time'})
yline(0.525,'-k', {'5% settle time'})
legend("Refrence Positon", "Measured Position", "1.5-sec","10% overshoot","5% settle time","5% settle time");
title("Test 1 (Without offset)")
xlabel('Time (sec)')
ylabel("Positon (rad)")
% saveas(gcf,"Fig_2_Test1_processed.png")

figure()
plot(t1,Torque_1)
title('Test 1')
xlabel('Time (sec)')
ylabel('Torque (mNm)')
grid on
% saveas(gcf,"Test1_Torque.png")

%% Test 2


t2 = T2(:,1)/1000 - T2(1,1)/1000;%% Converts ms to sec
ref_pos2 = T2(:,2);% Position in radians
mes_pos2 = T2(:,3);
mes_p2 = mes_pos2 - 0.02; %% If perfect response
Torque_2 = T2(:,4)*33.5;

figure()
plot(t2, ref_pos2);
grid on
hold on 
plot(t2, mes_pos2);
xline(6.84,'-r', {'1.5-sec'})
yline(-0.1,'-m', {'10% overshoot'})
yline(-0.05,'-k', {'5% settle time'})
yline(0.05,'-k', {'5% settle time'})
legend("Refrence Positon", "Measured Position", "1.5-sec","10% overshoot","5% settle time","5% settle time");
title("Test 2")
xlabel('Time (sec)')
ylabel("Positon (rad)")
 saveas(gcf,"Fig_3_Test2.png")

figure()
plot(t2, ref_pos2);
grid on
hold on 
plot(t2, mes_p2);
xline(6.84,'-r', {'1.5-sec'})
yline(-0.1,'-m', {'10% overshoot'})
yline(-0.05,'-k', {'5% settle time'})
yline(0.05,'-k', {'5% settle time'})
legend("Refrence Positon", "Measured Position", "1.5-sec","10% overshoot","5% settle time","5% settle time");
title("Test 2 (Without offset)")
xlabel('Time (sec)')
ylabel("Positon (rad)")
 saveas(gcf,"Fig_4_Test2_processed.png")



figure()
plot(t2,Torque_2)
title('Test 2')
xlabel('Time (sec)')
ylabel('Torque (mNm)')
grid on
% saveas(gcf,"Test2_Torque.png")



% Analysis 7


T_i_1 = readmatrix("k3_5");
T_i_2 = readmatrix("k3_10");
T_i_3 = readmatrix("k3_20");

t1_i = T_i_1(:,1)/1000 - T_i_1(1,1)/1000; %% Converts ms to sec
ref_pos1_i = T_i_1(:,2); % Position in radians
mes_pos1_i = T_i_1(:,3);
mes_p1_i = mes_pos1_i + .03;%- T_i_1(1,3); %% If perfect response
Torque_1_i = T_i_1(:,4)*33.5;


t2_i = T_i_2(:,1)/1000 - T_i_2(1,1)/1000; %% Converts ms to sec
ref_pos2_i = T_i_2(:,2); % Position in radians
mes_pos2_i = T_i_2(:,3);
mes_p2_i = mes_pos2_i -.07;%- T_i_2(1,3); %% If perfect response
Torque_2_i = T_i_2(:,4)*33.5;


t3_i = T_i_3(:,1)/1000 - T_i_3(1,1)/1000; %% Converts ms to sec
ref_pos3_i = T_i_3(:,2); % Position in radians
mes_pos3_i = T_i_3(:,3);
mes_p3_i = mes_pos3_i ;%- T_i_3(1,3); %% If perfect response
Torque_3_i = T_i_3(:,4)*33.5;


figure()
plot(t1_i, ref_pos1_i);
grid on
hold on 
plot(t1_i, mes_pos1_i);
xline(5.07,'-r', {'1.5-sec'})
yline(-0.1,'-m', {'10% overshoot'})
yline(-0.05,'-k', {'5% settle time'})
yline(0.05,'-k', {'5% settle time'})
legend("Refrence Positon", "Measured Position", "1.5-sec","10% overshoot","5% settle time","5% settle time");
title("K3 = 5 (Without offset)")
xlabel('Time (sec)')
ylabel("Positon (rad)")
 saveas(gcf,"k3_5P.png")

figure()
plot(t2_i, ref_pos2_i);
grid on
hold on 
plot(t2_i, mes_pos2_i);
xline(8.16,'-r', {'1.5-sec'})
yline(-0.1,'-m', {'10% overshoot'})
yline(-0.05,'-k', {'5% settle time'})
yline(0.05,'-k', {'5% settle time'})
legend("Refrence Positon", "Measured Position", "1.5-sec","10% overshoot","5% settle time","5% settle time");
title("K3 = 10")
xlabel('Time (sec)')
ylabel("Positon (rad)")
 saveas(gcf,"k3_10P.png")

figure()
plot(t3_i, ref_pos3_i);
grid on
hold on 
plot(t3_i, mes_pos3_i);
xline(6.69,'-r', {'1.5-sec'})
yline(-0.1,'-m', {'10% overshoot'})
yline(-0.05,'-k', {'5% settle time'})
yline(0.05,'-k', {'5% settle time'})
legend("Refrence Positon", "Measured Position", "1.5-sec","10% overshoot","5% settle time","5% settle time");
title("K3 = 20")
xlabel('Time (sec)')
ylabel("Positon (rad)")
 saveas(gcf,"k3_20P.png")

