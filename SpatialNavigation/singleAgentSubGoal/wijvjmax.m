function [ppp]=wijvjmax(Vs,connections,numOfNodes)
% load LatCon.txt
for iw=1:numOfNodes
    for jw=1:numOfNodes
        wmcal(iw,jw)=connections(iw,jw)*Vs(jw);
    end
end
ppp=0.8*max(wmcal');

    