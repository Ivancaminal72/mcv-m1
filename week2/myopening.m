function output = myopening(input, se)
    temp = myerode(input,se);
    output = mydilate(temp,se);
end