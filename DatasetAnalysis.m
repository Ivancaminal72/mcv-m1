
function dataset_analisis = DatasetAnalysis(directory)
  % call with > da = DatasetAnalysis("datasets/train")

  addpath('evaluation');

  % Create an empty array of structures
  dataset_analisis = struct([]);

  files = ListFiles(directory);
  % dataset_description = zeros(,10)

  for i=1:size(files,1)
    mask = imread(strcat(directory, '/mask/mask.', files(i).name(1:size(files(i).name,2)-3), 'png'))>0;
    [annotations signs] = LoadAnnotations(strcat(directory, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt')); 

    display(i)
    fflush(stdout)
    % There can be many signs in one picture, n_signs is the number of signs in this picture
    % size(annotations, 1) is the number of annotations in one picture
    for  j=1:size(annotations, 1)
      ann = annotations(j);
      display(j)
      fflush(stdout)

      % Form factor
      form_factor = ann.w / ann.h;

      % filling_ratio = FillingRatio(mask, ann.x, ann,y, ann.w, ann.h)
      filling_ratio = 0

      fila = struct('name', files(i).name, 'x', ann.x, 'y', ann.y, 'w', ann.w, 'h', ann.h, 'form_factor', form_factor, 'filling_ratio', filling_ratio);

      dataset_analisis(size(dataset_analisis,1) + 1,:) = fila;
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