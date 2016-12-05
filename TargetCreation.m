%% Target Creation

%Target size 10x750
%Data 256x750

load('numbersData')
target=eye(10);
targetFinal=[];
testTarget=[];
%Train
for i=1:75
    targetFinal=horzcat(targetFinal,target);
end

%Test
for i=1:5
    testTarget=horzcat(testTarget,target);
end

%% Perfect Target Creation

load('PerfectArial');
perfData=[];
for i=1:75
    perfData=horzcat(perfData,Perfect);
end

filename='perfData.mat';
filename2='targetFinal.mat';
save(filename,'perfData')
save(filename2,'targetFinal')
save('testTarget','testTarget')


