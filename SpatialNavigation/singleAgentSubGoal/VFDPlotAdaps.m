function [ppp]=VFDPlotAdaps(w,c,Vals)

%Drawing Points based
mka=max(Vals);
for i=1:size(c,1)
%     mcol=(1-vinit(i)/mka);
    mcol=Vals(i)/mka;
    if(mcol>0.8)
        plot(w(i,2),w(i,1),'marker','.','markersize',5,'markeredgecolor',[0 0.2 0.2]);
    end
    if((mcol<0.8)&&(mcol>0.1))
        plot(w(i,2),w(i,1),'marker','.','markersize',5,'markeredgecolor',[mcol 0.9 0.9]);
    end
     if(mcol<0.1)
        plot(w(i,2),w(i,1),'marker','.','markersize',5,'markeredgecolor',[0 0.1 0.9]);
    end
hold on
end    

for io=1:size(c,1)
        for jo=1:size(c,1)
             if(c(io,jo) ~=0)
               mcol=Vals(jo)/mka;
               if(mcol>0.8)
                   line([w(io,2),w(jo,2)],[w(io,1),w(jo,1)],'Color',[1 0.1 0.1]);
               end
               if((mcol>0.5)&&(mcol<0.8))
                   line([w(io,2),w(jo,2)],[w(io,1),w(jo,1)],'Color',[mcol+0.2 0.6 0.2]);
               end
               if((mcol<0.5)&&(mcol>0.1))
                    line([w(io,2),w(jo,2)],[w(io,1),w(jo,1)],'Color',[0.5+mcol 0.8 0.7]);
               end
               if(mcol<0.1)
                   line([w(io,2),w(jo,2)],[w(io,1),w(jo,1)],'Color',[0.1 0.3 0.9]);
               end
%                     mcol=(1-vinit(jo)/mka);
%                 line([w(io,1),w(jo,1)],[w(io,2),w(jo,2)],'Color',[mcol 0.9 0.9])
            end
        end
    end
hold on

ppp=0;



