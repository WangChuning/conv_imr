function [sol,norm_of_cha]=optm(x,y,A,AT,other_terms,n1,n2,n3,miu_1,miu_2,gamma,lambda, maxit)

cd 'D:\MATLAB\unlocbox' %已附在codes文件夹中
init_unlocbox();

z = x;

norm_of_cha = zeros([maxit,1]);
for j=1:maxit
    x_1=x;
    %x = prox_nuclearnorm(reshape(z,[n1*n2,n3]),2*gamma*miu_2);
    x = prox_nuclearnorm(reshape(z,[n1,n2]),2*gamma*miu_2);
    x = reshape(x,[n1*n2*n3,1]);
    m = 2 * x - z - gamma * 2*AT*(A*x+other_terms-y);
    m = prtv(reshape(m,[n1,n2,n3]),2*gamma*miu_1);
    z = z + lambda(j) * (reshape(m,[n1*n2*n3,1])-x );
    norm_of_cha(j)= norm(x-x_1,Inf);
end

sol = z;
close_unlocbox();
end



function y = prtv(x, gamma)

[n1,n2,n3]=size(x);

y = zeros(n1,n2,n3);

for i=1:n3
    y(:,:,i) = prox_tv(x(:,:,i),gamma);
end

    y(y<0)=0;

end
