function [wc] = SlidingWindow(mask, da, jump, combinations)
    
    [rows, cols] = size(mask);
    vcomb = getCombinations(combinations);
    
    for i = 1:jump:rows-window_h+1
        for j = 1:jump:cols-window_w+1
            
            sum = %TODO: obtain the sumatory
            
            
        end
    end
end

function vcomb = getCombinations(combinations)
    if(mod(combinations,2)==0 && combinations > 1)
        interval = (da('all').w_max-da('all').w_min)/combinations;
        for d = 1:combinations
            vcomb = [vcomb struct('w', (da('all').w_min)+interval*combinations, 'h', (da('all').h_min)+interval*combinations)];
        end
    elseif(combinations >1)
        interval = (da('all').w_max-da('all').w_min)/(combinations-1);
        for d = 1:combinations
            vcomb = [vcomb struct('w', (da('all').w_min)+interval*combinations, 'h', (da('all').h_min)+interval*combinations)];
        end
    else
        error('incorrect number of combinations');
    end   
end