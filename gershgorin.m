

function [xmin,xmax,ymin,ymax] = gershgorin (A,eps)
  center = diag(A);
  n = length (A);
  xPos = zeros(1,n);
  yPos = zeros(1,n);
  xNeg = zeros(1,n);
  yNeg = zeros(1,n);
  for i=1:n
    c = center(i);
    xc = real(c);
    yc = imag(c);
    rad = sum ( abs (A(i,:) ) ) - abs(c) + sqrt(n)*eps;
    xNeg(i) = xc - rad;
    xPos(i) = xc + rad;
    yNeg(i) = yc - rad;
    yPos(i) = yc + rad;
  end
  xmin = min(xNeg);
  xmax = max(xPos);
  ymin = min(yNeg);
  ymax = max(yPos);  
end
