egvl = zeros([7,1]);

for i = 1:7
        cd 'D:\Summer Research\7th try_testing by rand A\A & AT & y';
        file_name_A = ['A',num2str(i),'.mat'];
        file_name_AT = ['AT', num2str(i), '.mat'];
        load(file_name_AT);
        load(file_name_A);
        A = A./(10^4);
        AT = AT./(10^4);
        egvl(i)=max(eig(AT*A));
        file_name_for_A = ['D:\Summer Research\7th try_testing by rand A\A & AT & y\new\A',num2str(i),'.mat'];
        file_name_for_AT = ['D:\Summer Research\7th try_testing by rand A\A & AT & y\new\AT',num2str(i),'.mat'];
        save(file_name_for_A,'A','-v7.3');
        save(file_name_for_AT,'AT','-v7.3');
end
e=max(egvl);
