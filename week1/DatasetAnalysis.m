function [da] = DatasetAnalysis(directory) 
%call with  ->  da = DatasetAnalysis('datasets/train')
  
  disp(strcat('Analysing /', directory, '...'));
  files = ListFiles(directory);
  da = containers.Map;
  
  for i=1:size(files,1)
    mask = imread(strcat(directory, '/mask/mask.', files(i).name(1:size(files(i).name,2)-3), 'png'));
    %sig -> signs 
    [annotations, sig] = LoadAnnotations(strcat(directory, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt')); 
    
    % There can be many signs in one picture
    if size(sig, 2) ~= size(annotations, 1)
        error('Different size of signs/annotations');
    end
   
    for  j=1:size(annotations, 1)
      ann = annotations(j);
      % Apply Ceil function to obtain non zero integer pixel values
      ann.x = ceil(ann.x);
      ann.y = ceil(ann.y);
      ann.w = ceil(ann.w);
      ann.h = ceil(ann.h);
          
      % Form factor
      form_factor = ann.w / ann.h;
      % Filling ration
      filling_ratio = FillingRatio(mask(ann.y:ann.y+ann.h-1,ann.x:ann.x+ann.w-1), ann.w, ann.h);
      
      % Compute statistics of every signal type
      % Note!! that the field freq first is used as a counter
      if isKey(da, sig{j})
          % Update freq
          freq = da(sig{j}).freq+1;
          % Compute median for each caracteristic
          w_med = double(da(sig{j}).w_med)*(1-1/freq)+double(ann.w)*(1/freq);
          h_med = double(da(sig{j}).h_med)*(1-1/freq)+double(ann.h)*(1/freq);
          ff_med =  double(da(sig{j}).ff_med)*(1-1/freq)+double(form_factor)*(1/freq);
          fr_med =  double(da(sig{j}).fr_med)*(1-1/freq)+double(filling_ratio)*(1/freq);
          % Check min and max sizes
          w_max = da(sig{j}).w_max;
          h_max = da(sig{j}).h_max;
          ff_max = da(sig{j}).ff_max;
          fr_max = da(sig{j}).fr_max;
          max_area = da(sig{j}).max_area;
          w_min = da(sig{j}).w_min;
          h_min = da(sig{j}).h_min;
          ff_min = da(sig{j}).ff_min;
          fr_min = da(sig{j}).fr_min;
          min_area = da(sig{j}).min_area;
          
          if w_max < ann.w
              w_max = ann.w;
          elseif w_min > ann.w
              w_min = ann.w;
          end
          
          if h_max < ann.h
              h_max = ann.h;
          elseif h_min > ann.h
              h_min = ann.h;
          end
          
          if ff_max < form_factor
              ff_max = form_factor;
          elseif ff_min > form_factor
              ff_min = form_factor;
          end
          
          if fr_max < filling_ratio
              fr_max = filling_ratio;
          elseif fr_min > filling_ratio
              fr_min = filling_ratio;
          end
          
          if max_area<ann.w*ann.h
              max_area=ann.w*ann.h;
          elseif min_area>ann.w*ann.h
              min_area=ann.w*ann.h;
          end
          
          da(sig{j}) = struct('w_med', w_med, 'h_med', h_med, 'ff_med', ff_med, 'fr_med', fr_med, 'w_max', w_max, 'h_max', h_max, 'ff_max', ff_max, 'fr_max', fr_max, 'max_area', max_area, 'w_min', w_min, 'h_min', h_min, 'ff_min', ff_min, 'fr_min', fr_min, 'min_area', min_area, 'freq', freq);
      else
          da(sig{j}) = struct('w_med', ann.w, 'h_med', ann.h, 'ff_med', form_factor, 'fr_med', filling_ratio, 'w_max', ann.w, 'h_max', ann.h, 'ff_max', form_factor, 'fr_max', filling_ratio, 'max_area', ann.w*ann.h, 'w_min', ann.w, 'h_min', ann.h, 'ff_min', form_factor, 'fr_min', filling_ratio, 'min_area', ann.w*ann.h, 'freq', 1);
      end
      
      if isKey(da, 'all')
          % Update count
          count = da('all').count+1;
          % Compute median for each caracteristic
          w_med = double(da('all').w_med)*(1-1/count)+double(ann.w)*(1/count);
          h_med = double(da('all').h_med)*(1-1/count)+double(ann.h)*(1/count);
          ff_med =  double(da('all').ff_med)*(1-1/count)+double(form_factor)*(1/count);
          fr_med =  double(da('all').fr_med)*(1-1/count)+double(filling_ratio)*(1/count);
           % Check min and max sizes
          w_max = da('all').w_max;
          h_max = da('all').h_max;
          ff_max = da('all').ff_max;
          fr_max = da('all').fr_max;
          max_area = da('all').max_area;
          w_min = da('all').w_min;
          h_min = da('all').h_min;
          ff_min = da('all').ff_min;
          fr_min = da('all').fr_min;
          min_area = da('all').min_area;
          
          if w_max < ann.w
              w_max = ann.w;
          elseif w_min > ann.w
              w_min = ann.w;
          end
          
          if h_max < ann.h
              h_max = ann.h;
          elseif h_min > ann.h
              h_min = ann.h;
          end
          
          if ff_max < form_factor
              ff_max = form_factor;
          elseif ff_min > form_factor
              ff_min = form_factor;
          end
          
          if fr_max < filling_ratio
              fr_max = filling_ratio;
          elseif fr_min > filling_ratio
              fr_min = filling_ratio;
          end
          
          if max_area<ann.w*ann.h
              max_area=ann.w*ann.h;
          elseif min_area>ann.w*ann.h
              min_area=ann.w*ann.h;
          end
          
          da('all') = struct('w_med', w_med, 'h_med', h_med, 'ff_med', ff_med, 'fr_med', fr_med, 'w_max', w_max, 'h_max', h_max, 'ff_max', ff_max, 'fr_max', fr_max, 'max_area', max_area, 'w_min', w_min, 'h_min', h_min, 'ff_min', ff_min, 'fr_min', fr_min, 'min_area', min_area, 'count', count);
      else
          da('all') = struct('w_med', ann.w, 'h_med', ann.h, 'ff_med', form_factor, 'fr_med', filling_ratio, 'w_max', ann.w, 'h_max', ann.h, 'ff_max', form_factor, 'fr_max', filling_ratio, 'max_area', ann.w*ann.h, 'w_min', ann.w, 'h_min', ann.h, 'ff_min', form_factor, 'fr_min', filling_ratio, 'min_area', ann.w*ann.h, 'count', 1);
      end
    end
  end
  
  ks = keys(da);
  % Iterate map (except 'all' key) to normalize frequency of appearance
  for m = 1:length(da)-1
     update_struct = da(ks{m});
     update_struct.freq = da(ks{m}).freq/da('all').count;
     da(ks{m}) = update_struct;
  end
  disp('OK!');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FillingRatio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function fr = FillingRatio(signal, w, h)
    % The nnz function counts the number of non zero values of the matrix
    fr = nnz(signal)/(w*h);
end