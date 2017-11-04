function GenerateTemplates(dataset_dir, output_dir, out_name)
    %call with  ->  GenerateTemplates('datasets/train', 'week4/templates', 'mean_train.mat')
    
    CreateDir(output_dir, false);
    disp(strcat('Generating Templates /', dataset_dir, '...'));
    files = ListFiles(dataset_dir);
    da = DatasetAnalysis(dataset_dir); 
    
    %templates matrix channel correspondance:
    %Channel: 1 -> Triangles
    %Channel: 2 -> Inverse Triangles
    %Channel: 3 -> Circles
    %Channel: 4 -> Rectangles
    cols = int16(da('all').w_med);
    rows = int16(da('all').h_med);
    templates = zeros(rows, cols, 4);
    counter = zeros(4,1);
    
    for i=1:size(files,1)
        mask = imread(strcat(dataset_dir, '/mask/mask.', files(i).name(1:size(files(i).name,2)-3), 'png'));
        [annotations, signs] = LoadAnnotations(strcat(dataset_dir, '/gt/gt.', files(i).name(1:size(files(i).name,2)-3), 'txt')); 

        %Check equal size 
        if size(signs, 2) ~= size(annotations, 1)
            error('Different size of signs/annotations');
        end
        
        for  j=1:size(annotations, 1)
            ann = annotations(j);
            %Apply Ceil function to obtain non zero integer pixel values
            ann.x = ceil(ann.x);
            ann.y = ceil(ann.y);
            ann.w = ceil(ann.w);
            ann.h = ceil(ann.h);
            %Current sign label
            ann.s = signs{j};
            %Channel
            ann.c = 5;
          
            %Assing current channel           
            switch ann.s
                case 'A'
                    ann.c = 1; %triangles  
                case 'B'
                    ann.c = 2; %inverse_triangles               
                case {'C', 'D', 'E'}
                    ann.c = 3; %circles                
                case 'F'
                    ann.c = 4; %rectangles
            end
            
            %Compute the average templates
            window = double(mask(ann.y:ann.y+ann.h-1, ann.x:ann.x+ann.w-1));    
            window = imresize(window,[rows cols]); %with bicubic interpolation            
            templates(:,:,ann.c) = templates(:,:,ann.c) + window;
            counter(ann.c) = counter(ann.c) + 1;
        end
    end
    
    for c = 1:4
        templates(:,:,c) = templates(:,:,c) ./ counter(c);
    end
    
    %showtemplates(templates)
    save(strcat(output_dir,'/',out_name),'templates');
end

function showtemplates(templates)
    figure(1);
    subplot(2,2,1)
    imshow(templates(:,:,1))
    title('Triangles');
    subplot(2,2,2)
    imshow(templates(:,:,2))
    title('Inverse Triangles');
    subplot(2,2,3)
    imshow(templates(:,:,3))
    title('Circles');
    subplot(2,2,4)
    imshow(templates(:,:,4))
    title('Rectangles');
end