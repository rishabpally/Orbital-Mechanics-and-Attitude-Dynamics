%% Housekeeping
clc; clear; close all

%% Data Intake
% Torque Data 
Nm06 = load("2023_02_03_013_UNIT01_TORQ6_05");
%Nm10 = load("2023_02_03_013_UNIT01_TORQ1_10"); data nonexistent
Nm12 = load("2023_02_03_013_UNIT01_TORQ2_12");
Nm14 = load("2023_02_03_013_UNIT01_TORQ3_14");
Nm16 = load("2023_02_03_013_UNIT01_TORQ4_16");
Nm18 = load("2023_02_03_013_UNIT01_TORQ5_18");

% Gyro Data - Manual
manual1 = load("2023_23_01_013_UNIT2_RATEGYRO_MAN");
manual2 = load("2023_27_01_013_UNIT2__RATEGYRO_MAN_2");

% Gyro Data - Auto
auto1 = load("2023_27_01_013_UNIT2_RATEGYRO_AUTO_F0.2C0.5");
auto2 = load("2023_27_01_013_UNIT2_RATEGYRO_AUTO_F0.5C0.3");
auto3 = load("2023_27_01_013_UNIT2_RATEGYRO_AUTO_F0.4C0.75");

%% PART 1 - RATE GYRO MEASUREMENTS

[K1,s1] = plotting(auto1,"Raw Input/Output for F0.2, C0.5","Best Fit for F0.2, C0.5","Calibrated Rates for F0.2, C0.5","Angular Rate Error for F0.2, C0.5","True/Measured Positions for F0.2, C0.5","Position Error for F0.2, C0.5");
% = plotting(manual1);
[K2, s2] = plotting(auto2,"Raw Input/Output for F0.5, C0.3","Best Fit for F0.5, C0.3","Calibrated Rates for F0.5, C0.3","Angular Rate Error for F0.5, C0.3","True/Measured Positions for F0.5, C0.3","Position Error for F0.5, C0.3");
[K3, s3] = plotting(auto3,"Raw Input/Output for F0.4, C0.75","Best Fit for F0.4, C0.75","Calibrated Rates for F0.4, C0.75","Angular Rate Error for F0.4, C0.75","True/Measured Positions for F0.4, C0.75","Position Error for F0.4, C0.75");

% Mean/Std Calculations
K_mat = [K1, K2, K3];
bias_mat = [s1, s2, s3];
K_mean = (K1+K2+K3)/3;
bias_mean = (s1+s2+s3)/3;
K_std = std(K_mat);
bias_std = std(bias_mat);





%% Data Function
function [K,bias,K_mean,bias_mean] =  plotting(data,Title1,Title2,Title3,Title4,Title5,Title6)
data_time = data(2:end,1) - data(2,1);
data_output = data(2:end, 2);
data_input = data(2:end, 3);

% RPM Conversion
data_inputrad = data_input .* ((2*pi) / 60);

 % Manual Data Plot
 figure 
 hold on
 grid on
 plot(data_time, data_inputrad)
 plot(data_time, data_output, 'r')
 xlabel("Time [s]")
 ylabel("Rates [rad/s]")
 title(Title1)
 legend("Input","Output", "Location", "best")

% Calibraton Plot
p = polyfit(data_output,data_inputrad,1);
poly = polyval(p,data_inputrad);
figure 
hold on
grid on
plot(data_output, data_inputrad, ".", 'MarkerSize', 3)
plot(data_inputrad, poly, 'r', "LineWidth",1.1)
xlabel("Gyro Input [rad/s]")
ylabel("Gyro Output [rad/s]")
title(Title2)
legend("Data","Best Fit Line",'Location', "best")
K = p(1)
bias = p(2)

% Application Plot
figure
hold on
grid on
calib_output = data_output .* K + bias;
plot(data_time, data_inputrad,"k","LineWidth",1)
plot(data_time, calib_output, 'm',"LineStyle",'--',"LineWidth",1.5)
xlabel("Time [s]")
ylabel("Rates [rad/s]")
title(Title3)
legend("Input","Calib. Output","Location","Best")


% Angular Rate Error 
figure 
hold on
grid on
plot(data_time, calib_output - data_inputrad)
xlabel("Time [s]")
ylabel('Rate Error [rad/s]')
title(Title4)

% True + Measured Angular Position
delta_time = data_time(3) - data_time(2);
poschange_true = zeros(1,length(data_inputrad)-1);
poschange_meas = zeros(1,length(calib_output)-1);
for i = 2:length(data_inputrad)
    poschange_true(i) = poschange_true(i-1) + (delta_time * data_inputrad(i));
    poschange_meas(i) = poschange_meas(i-1) + (delta_time * calib_output(i));
end

% Position Graph
figure 
hold on
grid on
plot(data_time, poschange_true,'k',"LineWidth",1.25)
plot(data_time, poschange_meas,"color","#4CBB17","LineWidth",1.5,"LineStyle",'--')
xlabel("Time [s]")
ylabel("Angular Positions [rad]")
title(Title5)
legend("True Pos.","Measured Pos.","Location","best")

% Angular Position Error
figure 
hold on
grid on
plot(data_time, poschange_meas - poschange_true)
xlabel("Time [s]")
ylabel("Error [rad]")
title(Title6)

end