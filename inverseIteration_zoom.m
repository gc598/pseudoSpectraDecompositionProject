function [] = inverseIteration_zoom (m,eps,A,xmin,xmax,ymin,ymax)
  
  x = linspace(xmin,xmax,m);
  y = linspace(ymin,ymax,m);
  n = size(A);
  minSing = zeros(m);
  l = length(A);
  rad = 0;
  wb=waitbar(0,'Waiting...');
  parfor i=1:m
    for j=1:m
      v = randn(l,1) + 1i * randn(l,1);
      RST = (x(1,i) + 1i*y(1,j))*eye(n) - A;
      [L,U] = lu(RST);
      TrsCU = U';
      TrsCL = L';
      minEig = 1;
      minEigOld = 1;
      for k=1:100 
        v = U\(L\(TrsCU\(TrsCL\v)));
        minEig = 1/norm(v);
        if abs(minEigOld/minEig - 1)<0.01
          break;
        end;
        v = minEig * v;
        minEigOld = minEig;
      end
      minSing(i,j) = sqrt(minEig);   
    end
    waitbar(1-i/m);
  end
  delete(wb);
  contour(x,y,minSing,[eps,eps]);
  
end