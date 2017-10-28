function [windowCandidates] = CandidateGenerationWindow(mask, method, da, im)
    switch method
        case 'ccl'
            im = double(im);
            [windowCandidates] = SegmentationCCL(mask, da, im);
        case 'sliding_window'
            im = double(im);
            [windowCandidates] = SlidingWindow(mask, da, im);
        otherwise
            error('Incorrect method');
    end
end

function [wc] = SegmentationCCL(mask, da, im)
    %Cristina stuff...
    
end

function [wc] = SlidingWindow(mask, da, im)
    da['all']
end