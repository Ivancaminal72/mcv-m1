function output = myerode(input, se)
    %Binarize the structuring element
    for i=1:size(se,1)
        for j=1:size(se,2)
            if se(i,j)~=0 && se(i,j)~=1
                se(i,j)=1;
            end
        end
    end
    
    maxSize = max(size(se));
    minSize = min(size(se));
    %Normalize the structuring element to have NxN dimensions
    if maxSize ~= minSize
        if maxSize == size(se,1)
            se = [se, zeros(maxSize, maxSize-minSize)];
        else
            se = [se; zeros(maxSize-minSize, maxSize)];
        end
    end
    %Redefine the structuring element to have a center
    if rem(maxSize,2)==0 
        n_se = zeros(maxSize+1);
        se = [se,zeros(maxSize,1); zeros(1,maxSize+1)];
        maxSize = maxSize+1;
    else
        n_se = zeros(maxSize);
    end
    
    n_se = uint8(n_se | se);
    padding = ((maxSize+1)/2)-1;
    output = uint8(zeros(size(input)));
    %Add padding to the imput
    input = [255*ones(padding,size(input,2)+padding*2); 
        [255*ones(size(input,1),padding), input, 255*ones(size(input,1),padding)]; 
        255*ones(padding,size(input,2)+padding*2)];
    %Compute the output result
    for i=1:size(output,1)
        for j=1:size(output,2)
            output(i,j)=min(min(input(i:i+maxSize-1, j:j+maxSize-1) .* n_se));
        end
    end    
end