%S = [0,0,0;0,0,0;0,0,0];
%x = 2;
%y = 2;

%STAT = regionprops(output, 'ConvexHull');
% % %Cleanup through erosion looking for a specific SE
% for row = 1: ROWS
%     for cols = 1:COLS
%         if((row > 3 && row < ROWS-3) && (cols > 3 && cols < COLS-3))
%             
%             if((output(row-1,cols-1) == S(x-1,y-1)))
%                if((output(row, cols-1) == S(x,y-1)))
%                    if(output(row+1,cols-1) == S(x+1,y-1))
%                        if(output(row-1,cols) == S(x-1,y))
%                            if(output(row,cols) == S(x,y))
%                                if(output(row+1,cols) == S(x+1,y))
%                                    if(output(row-1,cols+1) == S(x-1,y+1))
%                                        if(output(row,cols+1) == S(x,y+1))
%                                            if(output(row+1,cols+1) == S(x+1,y+1))
%                                                 eroded_output(row,cols) = 1;
%                                            end
%                                        end
%                                    end
%                                end
%                            end
%                        end
%                    end
%                end
%             end
%         end
%     end
% end

%Boundary Exraction
%g = output - eroded_output;
%g = eroded_output;