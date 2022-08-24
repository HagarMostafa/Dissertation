%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPML111
% Project Title: Growing Neural Gas Network in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all;

%% Load Data

fname = ["room1.txt", "room2.txt", "room3.txt", "room4.txt", "corridor.txt","reception.txt"];
%load room4.txt
%data = load('mydata');
%X = room4;

fileID = fopen('connection_points.txt','wt');

flag = ones(900,1);

for i = 1:length(fname)
    
    X = textread(fname(i));


%% Parameters

    params.N = 150;

    params.MaxIt = 4;

    params.L = 10;

    params.epsilon_b = 0.2;
    params.epsilon_n = 0.0005;

    params.alpha = 0.5;
    params.delta = 0.995;

    params.T = 20;

    net = GrowingNeuralGasNetwork(X, params);
    fprintf("Finished training... now plotting \n")
    PlotResults(X,net.w,net.C,fileID,flag)

    connections_str = "connections_"+fname(i);
    points_str = "points_"+fname(i);
    writematrix(net.C,connections_str);
    writematrix(net.w,points_str);
    
end

fclose(fileID);

hold off;
axis equal;
grid on;
