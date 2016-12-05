function output= myclassify(data,filled)
%sprintf('Que classificador pretende utilizar? \n 1.AM+hardlim \n 2.AM+linear \n 3.AM+logsig \n 4.hardlim \n 5.linear \n 6.logsig')
choice=menu('Que classificador pretende utilizar?' ,'AM+hardlim','AM+linear','AM+logsig','hardlim','linear','logsig');

if choice == 1
    load('hardlimAM.mat');
 
elseif choice ==2
    load('linearAM.mat');
    
elseif choice == 3
    load('logsigAM.mat');

elseif choice ==4 
       load('hardlim.mat');

elseif choice ==5
    load('linear.mat');
    
elseif choice == 6
    load('logsig.mat');
   
end

results=net(data);
[x,y]=max(results);
output=int64(y(filled));
    
end
