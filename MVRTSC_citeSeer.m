clear
clc
close all

addpath('dataset','functions');
load('citeSeer_mtv.mat')
truth=gt;
clear gt
numClust = length(unique(truth));


A(:,:,1)=network_construction(fea{1}',2);
A(:,:,2)=network_construction(fea{2}',10);


mu = 7;              %best at 7  
lambda =  0.1;       %best at  0.1

for i=1:10
    fprintf('----MV-RTSC start, attempt number %d--------\n', i);
[Plabel,Timecost(i)] = MVRTSC(A,mu,lambda,numClust);
   fprintf('----MV-RTSC end, attempt number %d--------\n', i);
acc(i) =  Compute_accuracy(truth,Plabel);
        [Aa nmi(i) avgenti] = compute_nmi(truth,Plabel);
        [f(i),p(i),r(i)] = compute_f(truth,Plabel);
        if (min(truth)==0)
            [AR(i),RI,MI,HI]=RandIndex(truth+1,Plabel);
        else
            [AR(i),RI,MI,HI]=RandIndex(truth,Plabel);
        end 
end
fprintf('Acc: %.2f  (%.2f)\n' , mean(acc), std(acc));
fprintf('nmi: %.4f  (%.4f)\n' , mean(nmi), std(nmi));
fprintf('AR: %.4f   (%.4f)\n' , mean(AR), std(AR));
fprintf('F: %.4f    (%.4f)\n' , mean(f), std(f));
fprintf('P: %.4f    (%.4f)\n' , mean(p), std(p));
fprintf('R: %.4f    (%.4f)\n' , mean(r), std(r));
fprintf('Timecost: %.4f  \n\n' , mean(Timecost));