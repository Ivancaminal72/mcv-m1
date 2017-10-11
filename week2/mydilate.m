function output = mydilate(input, se)
    maxSize = max(size(se));
    if rem(maxSize,2)==0
        error('The se provided can not be a structural element');
    end
    %Normalize and Rotate the structural element
    n_se = zeros(maxSize);
    nr_se = n_se;
    n_se = n_se | se;
    for i=1:size(n_se,1)
        for j=1:size(n_se,2)
            nr_se(i,j) = n_se(maxSize-i+1, maxSize-j+1);
        end
    end
    padding = (((maxSize+1)/2)-1);
    %Add padding to the imput matrix
    input = [zeros(padding,size(input,2)+padding*2); 
        [zeros(size(input,1),padding), input, zeros(size(input,1),padding)]; 
        zeros(padding,size(input,2)+padding*2)];
    %Compute the output result
    output = zeros(size(input));
    for i=1:size(output,1)
        for j=1:size(output,2)
            output(i,j)=max(max(input(i:maxSize, j:maxSize) & nr_se));
        end
    end    
end
