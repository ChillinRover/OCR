function output = heuristicAprox(outputData)
    % This function returns the outputData, where each column max value is
    % turned to 1, and the rest to 0
    [M,I] = max(outputData);
    output = zeros(size(outputData,1),size(outputData,2));
    for i=1:length(I)
      output(I(i),i)=1;
    end
end