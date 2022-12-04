function[] = continuationTest_zoom(m,eps,A,xmin,xmax,ymin,ymax)
set(gca,'ytick',[ymin,ymax]);
set(gca,'xtick',[xmin,xmax]);
n = length(A);
tmp = eig(A);nbEig = length(tmp);
x = zeros(1,m*nbEig);  y = zeros(1,m*nbEig);
for j=1:nbEig
lambda = tmp(j);    
theta = eps;
d = rand()+rand()*1i;   d=(d/norm(d));
z1New = lambda + theta*d;

% computation of z1

sigma = eps;
while (abs(sigma-eps)/eps) >0.01
    z1Old = z1New;
    [sigma,u,v] = sigmaTest(z1Old*eye(n)-A);
    theta = (eps-sigma)/real((d') * (v') * u);
    z1New = lambda +theta*d;
end

z1 = z1New;
tau = 0.5; %%no specific compuation for tau
[~,u,v] = sigmaTest(z1*eye(n) - A);
x(1+m*(j-1)) = real(z1);  y(1+m*(j-1)) = imag(z1);
zNew = z1;

%prediction correction

for i=2:m
    zOld = zNew;
    r = ((v') * u * 1i) / norm((v') * u); 
    lambda = zOld +tau*r;
    [sigma,u,v] = sigmaTest(lambda * eye(n) - A);
    zNew = lambda + (eps-sigma)/( (u') * v);
    x(i+(j-1)*m) = real (zNew);  y(i+(j-1)*m) = imag(zNew);
end
end
scatter (x,y,'x');
hold on;
scatter(real(tmp),imag(tmp),'o');

end