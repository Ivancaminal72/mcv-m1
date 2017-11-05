function [windowCandidates] = CompareWithTemplate(mask, B, template_method)
    a=load ('./week4/templates/mean_train.mat');

    % Save as struct
    windowCandidates = struct('x',{},'y',{}, 'w',{},'h',{});

    switch template_method
        case 'subtraction'
            count=0;
            for i = 1:length(B)
                    ImB= mask(B(i).y:B(i).y+B(i).h-1,B(i).x:B(i).x+B(i).w-1);
                for j=1:4
                    T=a.templates(:,:,j);
                    ImB= imresize(ImB, size(T));
                    Diff=abs(T-ImB);
                    Sum=sum(sum(Diff));
                    Mean(j)=Sum/(size(Diff,1)*size(Diff,2));
                end

                if min(Mean)<0.4
                    count=count+1;
                    windowCandidates(count) = struct('x',double(B(i).x),'y',double(B(i).y),'w',double(B(i).w),'h',double(B(i).h));
                end
            end
            
        case 'correlation'
            count=0;
            for i = 1:length(B)
                    ImB= mask(B(i).y:B(i).y+B(i).h-1,B(i).x:B(i).x+B(i).w-1);
                for j=1:4
                    T=a.templates(:,:,j);
                    T=logical(T);
                    ImB= imresize(ImB, size(T));
                    Correlation=corrcoef(double(ImB), double(T));
                    diag=eye(size(Correlation));
                    Correlation=Correlation-diag;
                    C_value(j)=max(max(Correlation));
                end
                if max(C_value)>0.5
                    windowCandidates = struct('x',double(0),'y',double(0),'w',double(0),'h',double(0));
                    count=count+1;
                    windowCandidates(count) = struct('x',double(B(i).x),'y',double(B(i).y),'w',double(B(i).w),'h',double(B(i).h));
                 end
            end
         otherwise
             error('Incorrect method');
    end
end
