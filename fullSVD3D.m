function [] = fullSVD3D (m,A)
  [xmin,xmax,ymin,ymax] = gershgorin(A,0);
  x = linspace (xmin,xmax,m);
  y = linspace(ymin,ymax,m);
  n = size(A);
  singMin = zeros(m);
  Norm = zeros(m);
  
  wb=waitbar(0,'Waiting...');
  parfor i=1:m 
    for j=1:m
      z = x(1,i) + y(1,j)*1i;
      M = z*eye(n) - A;
      singMin(i,j) = min ( svd (M) ); 
      % Norm(i,j) = norm(inv(M));
    end
    waitbar(1-i/m);
  end
  delete(wb);
  %contour(x,y,log10(singMin),[eps,eps]);
  %contour3(x,y,singMin',30);
  surf(x,y,singMin');
end