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

function net = GrowingNeuralGasNetwork(X, params, PlotFlag)

    if ~exist('PlotFlag', 'var')
        PlotFlag = false;
    end

    %% Load Data
    
    nData = size(X,1);
    nDim = size(X,2);
    
    X = X(randperm(nData), :);

    Xmin = min(X);
    Xmax = max(X);

    %% Parameters

    MaxNodes = params.N;
    MaxIt = params.MaxIt;
    Lamda = params.L;
    epsilon_b = params.epsilon_b;
    epsilon_n = params.epsilon_n;
    alpha = params.alpha;
    delta = params.delta;
    maxAge = params.T;

    %% Initialization

    Ni = 2;

    nodes = zeros(Ni, nDim);
    for i = 1:Ni
        nodes(i,:) = unifrnd(Xmin, Xmax);
    end

    Error = zeros(Ni,1);

    edges = zeros(Ni, Ni);
    ages = zeros(Ni, Ni);

    %% Loop

    nx = 0;

    for it = 1:MaxIt
        fprintf("in iteration %d \n",it)
        for l = 1:nData
            % Select Input
            nx = nx + 1;
            Input = X(l,:);

            % Competion and Ranking
            d = pdist2(Input, nodes);
            [~, SortOrder] = sort(d);
            s1 = SortOrder(1);
            s2 = SortOrder(2);

            % Aging
            ages(s1, :) = ages(s1, :) + 1;
            ages(:, s1) = ages(:, s1) + 1;

            % Add Error
            Error(s1) = Error(s1) + d(s1)^2;

            % Adaptation
            nodes(s1,:) = nodes(s1,:) + epsilon_b*(Input-nodes(s1,:));
            Ns1 = find(edges(s1,:)==1);
            for j = Ns1
                nodes(j,:) = nodes(j,:) + epsilon_n*(Input-nodes(j,:));
            end

            % Create Link
            edges(s1,s2) = 1;
            edges(s2,s1) = 1;
            ages(s1,s2) = 0;
            ages(s2,s1) = 0;

            % Remove Old Links
            edges(ages>maxAge) = 0;
            nNeighbor = sum(edges);
            AloneNodes = (nNeighbor==0);
            edges(AloneNodes, :) = [];
            edges(:, AloneNodes) = [];
            ages(AloneNodes, :) = [];
            ages(:, AloneNodes) = [];
            nodes(AloneNodes, :) = [];
            Error(AloneNodes) = [];

            NumOfNodes = size(nodes,1);

            % Add New Nodes
            if mod(nx, Lamda) == 0 && NumOfNodes < MaxNodes

                % q & f are old nodes(index) 
                % and r is the new node(index)

                % find f with largest accumlated error
                % by multiplying error* q_Neighbors (edges(:,q))
                [~, q] = max(Error);
                [~, f] = max(edges(:,q).*Error);

                % +1 as we are adding a new node...
                r = NumOfNodes + 1;

                % Add the new node half-way between nodes q and f:
                nodes(r,:) = (nodes(q,:) + nodes(f,:))/2;

                % Remove the original edge between q and f.
                edges(q,f) = 0;
                edges(f,q) = 0;

                % Insert edges connecting the new unit r with units q and f.
                edges(q,r) = 1;
                edges(r,q) = 1;
                edges(r,f) = 1;
                edges(f,r) = 1;

                ages(r,:) = 0;
                ages(:,r) = 0;

                Error(q) = alpha*Error(q);
                Error(f) = alpha*Error(f);

                Error(r) = Error(q);
            end

            % Decrease Errors
            Error = delta*Error;
        end

        % Plot Results
        if PlotFlag
            figure(1);
            PlotResults(X, nodes, edges);
            pause(0.01);
            
        end
    end

    %% Export Results
    net.w = nodes;
    net.E = Error;
    net.C = edges;
    net.t = ages;

end