
load('siom_ori.mat');
load('siom.mat');

n1=40;
n2=90;
n3=1;

miu_1=2e-6; 
miu_2=2e-6;

lambda=ones(3,1);
maxit=3;

gamma=0.5;

SOL(1:7)={zeros([n1*n2,1])};

other_terms = zeros([n1*n2,1]);


final_sol_now = horzcat(SOL{1},SOL{2},SOL{3},SOL{4},SOL{5},SOL{6},SOL{7});
FRP=zeros([1000,1]);


%ORDER=zeros([500,7]);

for cycle = 1:1000 
    final_sol_last = final_sol_now;
    %order = randperm(7);
    %ORDER(cycle,:)=order; 
    
    for i = 1:7
        %i= order(i_old);
        
        cd 'D:\Summer Research\7th try_testing by rand A\A & AT & y\new'; %codes中文件的存储目录
        file_name_A = ['A',num2str(i),'.mat'];
        file_name_AT = ['AT', num2str(i), '.mat'];
        load(file_name_AT); 
        load(file_name_A);
        
        other_terms = other_terms - A * SOL{i};

        x = SOL{i};
        
        [sol, norm_of_cha]  = optm(x,y,A,AT,other_terms,n1,n2,n3,miu_1,miu_2,gamma,lambda, maxit);
        norm_of_CHA(cycle,i)= {norm_of_cha};
        SOL(i) = {sol};

        other_terms = other_terms + A * SOL{i};
        for j = 1:7
            x = SOL{j};
            
            x=reshape(x,[40,90]);
            F_SOL(j)={x};
        end
        
        final_sol_now = horzcat(SOL{1},SOL{2},SOL{3},SOL{4},SOL{5},SOL{6},SOL{7});
        FRP(cycle)=norm(final_sol_now-final_sol_last);
        
        final_sol = horzcat(F_SOL{1},F_SOL{2},F_SOL{3},F_SOL{4},F_SOL{5},F_SOL{6},F_SOL{7});
        L2NORM(cycle,i)={norm(reshape(final_sol-siom,[40*90*7,1]))};
        
        
    end
    if mod(cycle,10)==0
        cd 'D:\Summer Research\7th try_testing by rand A\double check'; %将程序每运行10 epoch之后的结果保存在该目录中
        
        final_sol = (final_sol-min(min(final_sol)))/(max(max(final_sol)) - min(min(final_sol)));
        
        for ii =1:7
            Anorm(ii) = {(F_SOL{ii} - min(min(F_SOL{ii})))/(max(max(F_SOL{ii})) - min(min(F_SOL{ii})))};
        end

        final_sol2 = horzcat(Anorm{1},Anorm{2},Anorm{3},Anorm{4},Anorm{5},Anorm{6},Anorm{7});
        
        name_for_cycle = ['result',num2str(cycle),'.mat'];
        name_for_final_sol = ['picture',num2str(cycle),'.png'];
        name_for_final_sol2 = ['picture2_',num2str(cycle),'.png'];
        clear A;
        clear AT;
        
        imwrite(final_sol,name_for_final_sol)
        imwrite(final_sol2,name_for_final_sol2)
        save(name_for_cycle)
    end
    
end
