function [windowCandidates] = CompareWithTemplate(mask, win)
    for i = 1:length(win)
        temp = mask(win(i).y:win(i).y+win(i).h-1,win(i).x:win(i).x+win(i).w-1);
        figure(1)
        imshow(temp)
        waitforbuttonpress();
    end
end