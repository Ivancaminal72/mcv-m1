function [windowCandidates] = CandidateGenerationWindow(mask, window_method, da, im)
    switch window_method
        case 'ccl'
            [windowCandidates] = SegmentationCCL(mask, da);
        case 'ccl_corr'
            [windowCandidates] = SegmentationCCL(mask, da);
            template_method = 'correlation';
            [windowCandidates] = CompareWithTemplate(mask, windowCandidates, template_method);
        case 'ccl_sub'
            [windowCandidates] = SegmentationCCL(mask, da);
            template_method = 'subtraction';
            [windowCandidates] = CompareWithTemplate(mask, windowCandidates, template_method);
        case 'sliding_window'
            params.overlap = true; %Do or not Overlap
            params.jump = 0.2; %Overlap in percentage of the sliding window  
            params.dims = 3; %Number width dimensions proved
            params.ffs = 3; %Number of form_factors proved
            params.method = 'simple'; %Filling ratio calculation method: 'sumcum' or 'simple'
            [windowCandidates] = SlidingWindow(mask, da, params);                      
        case 'sliding_window_corr'
            params.overlap = true; %Do or not Overlap
            params.jump = 0.2; %Overlap in percentage of the sliding window  
            params.dims = 3; %Number width dimensions proved
            params.ffs = 3; %Number of form_factors proved            
            [windowCandidates] = SlidingWindow(mask, da, params);              
            template_method = 'correlation';
            [windowCandidates] = CompareWithTemplate(mask, windowCandidates, template_method); 
        case 'sliding_window_sub'
            params.overlap = true; %Do or not Overlap
            params.jump = 0.2; %Overlap in percentage of the sliding window  
            params.dims = 3; %Number width dimensions proved
            params.ffs = 3; %Number of form_factors proved            
            [windowCandidates] = SlidingWindow(mask, da, params);              
            template_method = 'subtraction';
            [windowCandidates] = CompareWithTemplate(mask, windowCandidates, template_method); 
        case 'template_matching'
            params.overlap = true; %Do or not Overlap
            params.jump = 0.75; %Overlap in percentage of the sliding window  
            params.dims = 3; %Number width dimensions proved
            params.ffs = 3; %Number of form_factors proved
            params.threshold = 10; %Threshold that limits the result sumatory 
            [windowCandidates] = TemplateMatching(da, params, im);
        case 'hough'
            params.numpeaks = 100; %Number of lines of hough transform that we take into account
            params.t = 9; %Tolerance for horizontal and vertical lines (degres)           
            params.tt = 21; %Tolerance for tilted lines (degres)
            [windowCandidates] = HoughMethod(da, params, im);
        otherwise
            error('Incorrect method');
    end
end



