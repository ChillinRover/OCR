%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%        MAIN       %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% There are 2 architectures available:
% > 1 associative memory + classifier
% > 2 only classifier

% There are 3 activation functions:
% > 1 hardlim
% > 2 linear
% > 3 logsig 

% To calculate the intended network call OCR function with the inputs above, for
% example:
% OCR(1,1) ---> OCR with associative memory + classifier with hardlim

% We already preloaded all the networks combinations into the folder

% NOTE: if you run the OCR, the preloaded networks will be replaced by the
% new ones

%% To draw and classify

% A grid will appear, where the numbers that will be classified should be drawn.

% The logsig function with no associative memory is the best classifier!!

run('mpaper.m')
