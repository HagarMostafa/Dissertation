function [maxVal,maxIdx] = FindMax(mat,visited)
    maxVal = -100;
    maxIdx = 0;
    for i =1:1:size(mat,1)
        if(mat(i) > maxVal)
            foundInVisited = false;
            for j=1:1:size(visited,2)
                if(i == visited(j))
                    foundInVisited = true;
                    break 
                end
            end
            if(foundInVisited == false)
                maxVal = mat(i);
                maxIdx = i;
            end
        end

    end
    if(maxIdx == 0)
        fprintf("Error no max value...all visited")
    end
end