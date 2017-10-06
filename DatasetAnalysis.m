
function dataset_analisis = DatasetAnalysis(directory)
  % call with > da = DatasetAnalysis('datasets/train')

  addpath('evaluation');

  files = ListFiles(directory);
  % dataset_description = zeros(,10)

  for i=1:size(files,1)
    mask = imread(strcat(directory, '/mask/mask.', files(i).name(1:size(files(i).name,2)-3), 'png'))>0;
    [annotations signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt')); 

    i
    
    % There can be many signs in one picture, n_signs is the number of signs in this picture
    % size(annotations, 1) is the number of annotations in one picture
    for  j=1:size(annotations, 1)
      ann = annotations(j);

      % Form factor
      form_factor = ann.w / ann.h;

      % filling_ratio = FillingRatio(mask, ann.x, ann,y, ann.w, ann.h)
      filling_ratio = 0;

      dataset_analisis(i) = struct('name', files(i).name, 'x', ann.x, 'y', ann.y, 'w', ann.w, 'h', ann.h, 'form_factor', form_factor, 'filling_ratio', filling_ratio);
      
    end
  end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FillingRatio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [filling_ratio] = FillingRatio(mask, x, y, w, h)

end