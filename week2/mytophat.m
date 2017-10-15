function output = mytophat(input, se)
    temp = myopening(input,se);
    output = input-temp;
end