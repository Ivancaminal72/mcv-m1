function [windowCandidates] = CandidateGenerationWindow(mask, window_method, da)
    switch window_method
        case 'ccl'
            [windowCandidates] = SegmentationCCL(mask, da);
        case 'sliding_window'
            params.overlap = true; %Do or not Overlap
            params.jump = 0.5; %Overlap in percentage of the sliding window  
            params.dims = 3; %Number width dimensions proved
            params.ffs = 3; %Number of form_factors proved
            params.method = 'simple'; %'sumcum' or 'simple'
            tic;
            [windowCandidates] = SlidingWindow(mask, da, params);
            toc;
        otherwise
            error('Incorrect method');
    end
end



