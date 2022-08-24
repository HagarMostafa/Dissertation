function [goalPoint] = getDoorPoint(globalReward,doorPoints,subGoalCluster,currentCluster)

allDoorPoints = [];
countDoorPoint = 0;
allDoorPointsReward = [];
for i=1:size(doorPoints,1)
    if((subGoalCluster == doorPoints(i,2)) && (currentCluster ==  doorPoints(i,3)))
        countDoorPoint = countDoorPoint + 1;
        allDoorPoints(countDoorPoint) = i;
        allDoorPointsReward(countDoorPoint) = globalReward(doorPoints(i,1));
    end
end
[ignore, maxIdx] = max(allDoorPointsReward);
goalPoint = doorPoints(allDoorPoints(maxIdx),1);
end