function [] = fullSVD_zoom (m,eps,A,xmin,xmax,ymin,ymax)
  x = linspace (xmin,xmax,m);
  y = linspace(ymin,ymax,m);
  n = size(A);
  singMin = zeros(m);
 
  wb=waitbar(0,'Waiting...');
  parfor i=1:m    
    for j=1:m
      z = x(1,i) + y(1,j)*1i;
      M = z*eye(n) - A;
      singMin(i,j) = min ( svd (M) ); 
    end
    waitbar(1-i/m);
  end
  delete(wb);
  %delete(gcp('nocreate'));
  contour(x,y,(singMin'),[eps,eps]);
end
