function res = exac(Test_Set,Target_Set)
    % This function compares de network output with the targets to
    % calculate accuracy
    j=0;    
    for i=1:size(Test_Set,2)
        if Test_Set(:,i) == Target_Set(:,i)
            j = j+1;
        end
    end
    res = j/size(Test_Set,2);
end