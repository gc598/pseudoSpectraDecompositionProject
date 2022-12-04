function[s,u,v] = sigmaTest(A)
[U,S,V] = svds(A);
[s1,s2] = size(S);
[u1,u2] = size(U);
[v1,v2] = size(V);
s = S(s1,s2);
u = U((1:u1),u2);
v = V((1:v1),v2);
end