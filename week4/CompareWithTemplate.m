function [windowCandidates] = CompareWithTemplate(mask, B,template_method)
addpath(templates)
a=load ('mean_train.mat');
   switch template_method
        case 'substration'

        case 'correlation'
            for i = 1:length(B)
                    ImB= mask(B(i).y:B(i).y+B(i).h-1,B(i).x:win(i).x+B(i).w-1);
                for j=1:4
                    T=a.templates(:,:,j);
                    T=logical(T);
                    ImB= imresize(ImB, size(T));
                    Correlation=corrcoef(ImB,T);
                    diag=eye(size(Correlation));
                    Correlation=Correlation-diag;
                    C_value(j)=max(max(Correlation));
                end
                if max(C_value)>0.5
                 if (size(B.x) ~= 0)
                    windowCandidates = [struct('x',double(0),'y',double(0),'w',double(0),'h',double(0))];
                    for i=1:size(BB_box, 1)
                        windowCandidates(i) = [struct('x',double(B(i).x),'y',double(B(i).y),'w',double(B(i).w),'h',double(B(i).h))];
                    end
                 end
                end
            end
            
        otherwise
            error('Incorrect method');
    end

