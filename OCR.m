function OCR(architecture,activationF)

run('TargetCreation.m')
% After used, the network used will be saved in a net.m file for later use
% if needed

% A test matrix was created - test.mat
% There are 2 architectures available:
% > 1 associative memory + classifier
% > 2 only classifier


% There are 3 activation functions:
% > 1 hardlim
% > 2 linear
% > 3 logsig 

%Loads
load('perfData.mat');
load('targetFinal.mat');
load('numbersData.mat');
load('test.mat','P')
load('testTarget.mat')

if architecture==1
    % Associative Memory
    weight = perfData*pinv(matrizFinal1);
    numbersDataAM=weight*matrizFinal1;
    P=weight*P;
    
    % hardlim
    if activationF==1
        % net = newp(p,t,tf,lf)  - 10 neurons used
        net = network(repmat([0 1],[256 1]),10, 'hardlim' , 'learnp' );
        
        %weights and biases
        W=rand(10,256);
        b=rand(10,1);
        net.IW{1,1}=W;
        net.b{1,1}=b;
        
        % net parameters
        net.performParam.lr=0.5;
        net.trainParam.epochs =500;
        net.trainParam.show =35;
        net.trainParam.goal =1e-6;
        
        % Data Division
        net.performFcn ='sse';
        net.divideFcn = 'dividerand';           % Divide data randomly
        net.divideMode = 'sample';              % Divide up every sample
        net.divideParam.trainRatio = 80/100;
        net.divideParam.valRatio = 10/100;
        net.divideParam.testRatio = 10/100;
        
        %Train
        [net,tr]=train(net,numbersDataAM,targetFinal);
        
        %View the Network
        outputs = net(numbersDataAM);
        errors = gsubtract(outputs,targetFinal);
        performance = perform(net,targetFinal,outputs);
        
        plotperf(tr)
  
      % plotting the roc curves
        figure
        outputs2=sim(net,P)
        plotroc(targetFinal,outputs)
        figure
        plotroc(testTarget,outputs2)
        
        sprintf('Train performance( %)')
        exac(outputs,targetFinal)*100
        sprintf('Test performance( %)')
        exac(outputs2,testTarget)*100
        
        hardlimAM=net;
        save hardlimAM
    % linear     
    elseif activationF==2
        % net = newp(p,t,tf,lf)  - 10 neurons used
        net = newp(repmat([0 1],[256 1]),10, 'purelin' , 'learngd' );
        
        %weights and biases
        W=rand(10,256);
        b=rand(10,1);
        net.IW{1,1}=W;
        net.b{1,1}=b;
        
        % net parameters
        net.performParam.lr=0.5;
        net.trainParam.epochs =500;
        net.trainParam.show =35;
        %net.trainParam.goal =1e-6;
        
        % Data Division
        net.performFcn ='sse';
        net.divideFcn = 'dividerand';           % Divide data randomly
        net.divideMode = 'sample';              % Divide up every sample
        net.divideParam.trainRatio = 80/100;
        net.divideParam.valRatio = 10/100;
        net.divideParam.testRatio = 10/100;
        
        %Train
        [net,tr]=train(net,numbersDataAM,targetFinal);
        
        %View the Network
        outputs = net(numbersDataAM);
        errors = gsubtract(outputs,targetFinal);
        performance = perform(net,targetFinal,outputs);
        
        plotperf(tr)
      %  view(net)
      
        outputs2=sim(net,P)
        %To compare with the target matrix, we need to take the max val of
        %each column and turn it to 1. The remaining values in the column should be 0
        outputs2=heuristicAprox(outputs2);
        outputs=heuristicAprox(outputs);
        
        % plotting the roc curves
        figure
        plotroc(targetFinal,outputs)
        figure
        plotroc(testTarget,outputs2)
        
        sprintf('Train performance (%)')
        exac(outputs,targetFinal)*100
        sprintf('Test performance (%)')
        exac(outputs2,testTarget)*100
        
        linearAM=net;
        save linearAM
    % logsig    
    elseif activationF==3
        % net = newp(p,t,tf,lf)  - 10 neurons used
        net = newp(repmat([0 1],[256 1]),10, 'logsig' , 'learnp' );
        
        %weights and biases
        W=-6+12*rand(10,256);           
        b=-6+12*rand(10,1);             
        net.IW{1,1}=W;
        net.b{1,1}= b;
        
        % net parameters
        net.performParam.lr=0.5;
        net.trainParam.epochs =500;
        net.trainParam.show =35;
        %net.trainParam.goal =1e-6;
        
        % Data Division
        net.performFcn ='sse';
        net.divideFcn = 'dividerand';           % Divide data randomly
        net.divideMode = 'sample';              % Divide up every sample
        net.divideParam.trainRatio = 80/100;
        net.divideParam.valRatio = 10/100;
        net.divideParam.testRatio = 10/100;
        
        %Train
        [net,tr]=train(net,numbersDataAM,targetFinal);
        
        %View the Network
        outputs = net(numbersDataAM);
        errors = gsubtract(outputs,targetFinal);
        performance = perform(net,targetFinal,outputs);
        
        plotperf(tr)
      %  view(net)
      
        outputs2=sim(net,P)
        %To compare with the target matrix, we need to take the max val of
        %each column and turn it to 1. The remaining values in the column should be 0
        outputs2=heuristicAprox(outputs2);
        outputs=heuristicAprox(outputs);
        
        % plotting the roc curves
        figure
        plotroc(targetFinal,outputs)
        figure
        plotroc(testTarget,outputs2)
        
        sprintf('Train performance (%)')
        exac(outputs,targetFinal)*100
        sprintf('Test performance (%)')
        exac(outputs2,testTarget)*100
        
        logsigAM=net;
        save logsigAM
    end
else
    % architecture - only classifier
     if activationF==1
        % net = newp(p,t,tf,lf)  - 10 neurons used
        net = newp(repmat([0 1],[256 1]),10, 'hardlim' , 'learnp' );
        
        %weights and biases
        W=rand(10,256);
        b=rand(10,1);
        net.IW{1,1}=W;
        net.b{1,1}=b;
        
        % net parameters
        net.performParam.lr=0.5;
        net.trainParam.epochs =500;
        net.trainParam.show =35;
        net.trainParam.goal =1e-5;
        
        % Data Division
        net.performFcn ='sse';
        net.divideFcn = 'dividerand';           % Divide data randomly
        net.divideMode = 'sample';              % Divide up every sample
        net.divideParam.trainRatio = 80/100;
        net.divideParam.valRatio = 10/100;
        net.divideParam.testRatio = 10/100;
        
        %Train
        [net,tr]=train(net,matrizFinal1,targetFinal);
        
        %View the Network
        outputs = net(matrizFinal1);
        errors = gsubtract(outputs,targetFinal);
        performance = perform(net,targetFinal,outputs);
        
        plotperf(tr)
  
      % plotting the roc curves
        figure
        outputs2=sim(net,P)
        plotroc(targetFinal,outputs)
        figure
        plotroc(testTarget,outputs2)
        
        sprintf('Train performance (%)')
        exac(outputs,targetFinal)*100
        sprintf('Test performance (%)')
        exac(outputs2,testTarget)*100
        
        hardlim=net;
        save hardlim
    % linear     
    elseif activationF==2
        % net = newp(p,t,tf,lf)  - 10 neurons used
        net = newp(repmat([0 1],[256 1]),10, 'purelin' , 'learngd' );
        
        %weights and biases
        W=rand(10,256);
        b=rand(10,1);
        net.IW{1,1}=W;
        net.b{1,1}=b;
        
        % net parameters
        net.performParam.lr=0.5;
        net.trainParam.epochs =500;
        net.trainParam.show =35;
        %net.trainParam.goal =1e-6;
        
        % Data Division
        net.performFcn ='sse';
        net.divideFcn = 'dividerand';           % Divide data randomly
        net.divideMode = 'sample';              % Divide up every sample
        net.divideParam.trainRatio = 80/100;
        net.divideParam.valRatio = 10/100;
        net.divideParam.testRatio = 10/100;
        
        %Train
        [net,tr]=train(net,matrizFinal1,targetFinal);
        
        %View the Network
        outputs = net(matrizFinal1);
        errors = gsubtract(outputs,targetFinal);
        performance = perform(net,targetFinal,outputs);
        
        plotperf(tr)
      %  view(net)
      
        outputs2=sim(net,P)
        %To compare with the target matrix, we need to take the max val of
        %each column and turn it to 1. The remaining values in the column should be 0
        outputs2=heuristicAprox(outputs2);
        outputs=heuristicAprox(outputs);
        
        % plotting the roc curves
        figure
        plotroc(targetFinal,outputs)
        figure
        plotroc(testTarget,outputs2)
           
        sprintf('Train performance (%)')
        exac(outputs,targetFinal)*100
        sprintf('Test performance (%)')
        exac(outputs2,testTarget)*100
        
        linear=net;
        save linear
        
    % logsig    
    elseif activationF==3
        % net = newp(p,t,tf,lf)  - 10 neurons used
        net = newp(repmat([0 1],[256 1]),10, 'logsig' , 'learnp' );
        
        %weights and biases
        W=-6+12*rand(10,256);           
        b=-6+12*rand(10,1);             
        net.IW{1,1}=W;
        net.b{1,1}= b;
        
        % net parameters
        net.performParam.lr=0.5;
        net.trainParam.epochs =500;
        net.trainParam.show =35;
        %net.trainParam.goal =1e-6;
        
        % Data Division
        net.performFcn ='sse';
        net.divideFcn = 'dividerand';           % Divide data randomly
        net.divideMode = 'sample';              % Divide up every sample
        net.divideParam.trainRatio = 80/100;
        net.divideParam.valRatio = 10/100;
        net.divideParam.testRatio = 10/100;
        
        %Train
        [net,tr]=train(net,matrizFinal1,targetFinal);
        
        %View the Network
        outputs = net(matrizFinal1);
        errors = gsubtract(outputs,targetFinal);
        performance = perform(net,targetFinal,outputs);
        
        plotperf(tr)
      %  view(net)
      
        outputs2=sim(net,P)
        %To compare with the target matrix, we need to take the max val of
        %each column and turn it to 1. The remaining values in the column should be 0
        outputs2=heuristicAprox(outputs2);
        outputs=heuristicAprox(outputs);
        
        % plotting the roc curves
        figure
        plotroc(targetFinal,outputs)
        figure
        plotroc(testTarget,outputs2)
        
        sprintf('Train performance (%)')
        exac(outputs,targetFinal)*100
        sprintf('Test performance (%)')
        exac(outputs2,testTarget)*100
        
        logsig=net;
        save logsig
    end
        
end
