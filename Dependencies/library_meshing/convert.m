function dimension = convert(string)
    if isnumeric(string)
        dimension = string;
    else
        switch string
            case 'x'
                dimension = 1;
            case 'y'
                dimension = 2;
            case 'z'
                dimension = 3;
        end
    end
end