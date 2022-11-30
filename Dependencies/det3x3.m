plocha = 0;
for i = 1:size(elements,1)
    plocha = plocha + det([coordinates(elements(i,:),:),[1;1;1;]])/2;
end