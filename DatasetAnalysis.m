
function [dataset_analisis, signal_freq] = DatasetAnalysis(directory)
  % call with -> [da, freq] = DatasetAnalysis('datasets/train')

  addpath('evaluation');

  files = ListFiles(directory);
  % dataset_description = zeros(,10)
    
  signal_freq = containers.Map;
  number_signals = 0;
  
  for i=1:size(files,1)
    mask = imread(strcat(directory, '/mask/mask.', files(i).name(1:size(files(i).name,2)-3), 'png'));
    [annotations signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt')); 
    
    i
    
    % There can be many signs in one picture, n_signs is the number of signs in this picture
    % size(annotations, 1) is the number of annotations in one picture
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
        
      % Add structure
      dataset_analisis(i) = struct('name', files(i).name, 'x', ann.x, 'y', ann.y, 'w', ann.w, 'h', ann.h, 'form_factor', form_factor, 'filling_ratio', filling_ratio);
    end
    
    % Count how many signals of specific signal type are
    for  k=1:size(signs, 1)
        number_signals=number_signals+1;
        if isKey(signal_freq, signs{k})
            signal_freq(signs{k}) = signal_freq(signs{k})+1;
        else
            signal_freq(signs{k}) = 1;
        end
    end
  end
  sf_keys = keys(signal_freq);
  
  % Iterate map to normalize frequency of appearance
  for m = 1:length(signal_freq)
     signal_freq(sf_keys{m}) = signal_freq(sf_keys{m})/number_signals;
  end
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