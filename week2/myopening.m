function output = myopening(input, se)
    temp = mydilate(input,se);
    output = myerode(temp,se);
end