function [] = plotGoalAndTarget(nodesMat,goalPointIdx,startPointIdx,switchAxis)
    if(switchAxis)
        plot(nodesMat(goalPointIdx,2),nodesMat(goalPointIdx,1),'marker','*','markersize',15,'markeredgecolor','k');
        hold on
        plot(nodesMat(startPointIdx,2),nodesMat(startPointIdx,1),'marker','*','markersize',35,'markeredgecolor','k');
        hold on
    else
        plot(nodesMat(goalPointIdx,1),nodesMat(goalPointIdx,2),'marker','*','markersize',15,'markeredgecolor','k');
        hold on
        plot(nodesMat(startPointIdx,1),nodesMat(startPointIdx,2),'marker','*','markersize',35,'markeredgecolor','k');
        hold on
    end
end