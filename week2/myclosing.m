function output = myclosing(input, se)
    temp = mydilate(input,se);
    output = myerode(temp,se);
end