function [windowCandidates] = CandidateGenerationWindow(mask, window_method, da, im)
    switch window_method
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
            params.method = 'simple'; %'sumcum' or 'simple'
            %tic;
            [windowCandidates] = SlidingWindow(mask, da, params);
            %toc;      
            %disp(length(windowCandidates));
            template_method = 'subtraction';
            [windowCandidates] = CompareWithTemplate(mask, windowCandidates, template_method);
            %disp(length(windowCandidates));
            %waitforbuttonpress();
        case 'template_matching'
            params.overlap = true; %Do or not Overlap
            params.jump = 0.75; %Overlap in percentage of the sliding window  
            params.dims = 3; %Number width dimensions proved
            params.ffs = 3; %Number of form_factors proved
            params.threshold = 10; %Threshold that limits the result sumatory 
            %tic;
            [windowCandidates] = TemplateMatching(mask, da, params, im);
            disp(length(windowCandidates));
            %toc;
        otherwise
            error('Incorrect method');
    end
end



