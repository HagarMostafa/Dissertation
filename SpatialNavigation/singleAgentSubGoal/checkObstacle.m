function flag =  checkObstacle(points, startX, startY, lengthX, lengthY, flag)

    for i = 1:length(points)

        if points(i,1) >= startX && points(i,1) <= startX+lengthX && points(i,2) >= startY && points(i,2) <= startY+lengthY 
            %disp([points1(i,1), points1(i,2)]);
            flag(i) = 0;

        end
        
    end

 end