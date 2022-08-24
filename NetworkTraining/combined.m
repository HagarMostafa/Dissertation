clc 
clear 


fileID = fopen('connection_points.txt','wt');
flagFile = fopen('flags.txt','wt');

connections1 = load('connections_room1.txt');
points1 = load('points_room1.txt');

connections2 = load('connections_room2.txt');
points2 = load('points_room2.txt');

connections3 = load('connections_room3.txt');
points3 = load('points_room3.txt');

connections4 = load('connections_room4.txt');
points4 = load('points_room4.txt');

connections5 = load('connections_corridor.txt');
points5 = load('points_corridor.txt');

connections6 = load('connections_reception.txt');
points6 = load('points_reception.txt');


pointsCombined = [points1;points2;points3;points4;points5;points6];

connectionsCombined = zeros(length(pointsCombined));

connectionsCombined(1:150,1:150) = connections1;
connectionsCombined(151:300,151:300) = connections2;
connectionsCombined(301:450,301:450) = connections3;
connectionsCombined(451:600,451:600) = connections4;
connectionsCombined(601:750,601:750) = connections5;
connectionsCombined(751:end,751:end) = connections6;

connectionsCombined(486,612) = 1;
connectionsCombined(612,486) = 1;

connectionsCombined(679,107) = 1;
connectionsCombined(107,679) = 1;

connectionsCombined(301,669) = 1;
connectionsCombined(669,301) = 1;

connectionsCombined(687,257) = 1;
connectionsCombined(257,687) = 1;

connectionsCombined(672,794) = 1;
connectionsCombined(794,672) = 1;

flag = ones(length(pointsCombined),1);

%room1
flag = checkObstacle(pointsCombined, 8000, 5000, 1000, 500,flag);
flag = checkObstacle(pointsCombined, 9000, 6000, 500, 700,flag);

%room2
flag = checkObstacle(pointsCombined, 10000, 3000, 1000, 500,flag);
flag = checkObstacle(pointsCombined, 9000, 2000, 500, 700,flag);

%room3
flag = checkObstacle(pointsCombined, 4000, 3000, 1000, 200,flag);
flag = checkObstacle(pointsCombined, 3000, 2000, 800, 500,flag);

%room4
flag = checkObstacle(pointsCombined, 4000, 7000, 1000, 400,flag);
flag = checkObstacle(pointsCombined, 2000, 5000, 400, 400,flag);
flag = checkObstacle(pointsCombined, 2000, 6000, 600, 500,flag);


clusters = zeros(length(pointsCombined),1);
clusters(1:150) = 1;
clusters(151:300) = 2;
clusters(301:450) = 3;
clusters(451:600) = 4;
clusters(601:750) = 5;
clusters(751:end) = 6;


PlotResults(pointsCombined,pointsCombined,connectionsCombined,fileID,flag)

writematrix(pointsCombined,"points_combined");
writematrix(connectionsCombined,"connections_combined");
writematrix(clusters,"clusters");

for i= 1:length(flag)
    fprintf(flagFile,'%d\n',flag(i));
end

fclose(flagFile);
fclose(fileID);
%room1Connection =  textread('connections_room4.txt');