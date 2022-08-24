function [idxOfNeigh]=NearNeigh(Vs,connectionsMap,currentPosition,numOfNodes)
maxIdx=0;
maxVal=-100;
for nodeIdx=1:numOfNodes
    if((connectionsMap(currentPosition,nodeIdx) >0) && (currentPosition~=nodeIdx))
        connectedVals(nodeIdx) = Vs(nodeIdx); 
        if(connectedVals(nodeIdx)>maxVal)
            maxVal=connectedVals(nodeIdx);
            maxIdx=nodeIdx;
        end
    end
end
if(maxIdx == 0)
    fprintf('error in NearNeigh ... no max value \n')
end
idxOfNeigh=maxIdx;

