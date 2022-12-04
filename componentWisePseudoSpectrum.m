function [] = componentWisePseudoSpectrum(m,eps,E,A)
    n = length(A);
    [xmin,xmax,ymin,ymax] = gershgorin(A,eps);
    x = linspace(xmin,xmax,m);
    y = linspace(ymin,ymax,m);
    res = zeros(m);
    for i=1:m
        for j=1:m
            z = x(i) +y(j)*1i ;
            tmp = abs(inv(A - z * eye (n) ) ) * E;
            res(i,j) = max(abs(eig(tmp)));
        end
    end
    contour(x,y,res',[eps,eps]);
end        
    