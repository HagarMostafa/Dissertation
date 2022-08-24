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
load allSpace.txt
%data = load('mydata');
X = allSpace;

%% Parameters

params.N = 2000;

params.MaxIt = 4;

params.L = 10;

params.epsilon_b = 0.2;
params.epsilon_n = 0.0005;

params.alpha = 0.5;
params.delta = 0.995;

params.T = 20;

net = GrowingNeuralGasNetwork(X, params);
fprintf("Finished training... now plotting \n")
PlotResults(X,net.w,net.C)
