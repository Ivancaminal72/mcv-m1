function [windowCandidates] = CandidateGenerationWindow(mask, window_method, da)
    switch window_method
        case 'ccl'
            [windowCandidates] = SegmentationCCL(mask, da);
        case 'sliding_window'
            params.jump = 10; %Jump of the sliding window
            params.dims = 3; %Number width dimensions proved
            params.ffs = 3; %Number of form_factors proved
            params.method = 'sumcum'; %'sumcum' or 'simple'
            
            [windowCandidates] = SlidingWindow(mask, da, params);
        otherwise
            error('Incorrect method');
    end
end



