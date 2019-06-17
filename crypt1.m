function y = crypt1(M,N,e)
  %disp(M);
  if  mod(e,2)~=0 && e>1
  y=mod((mod(M,N)*crypt1(M,N,e-1)),N);
  %disp('a')
  %disp(['The value of Y1 is: ' num2str(y)]);
  return 
  elseif mod(e,2)==0
  y=mod((mod(crypt1(M,N,e/2),N)*mod(crypt1(M,N,e/2),N)),N);
  %z1=(rec(N,M,e/2)^2);
  %y=mod(z1,N);
  %disp('b')
  %disp(z1)
  %disp(['The value of Y2 is: ' num2str(y)]);
  %disp(N)
  return
  else 
  y=mod(M,N);
  %disp('c')
  %disp(['The value of Y3 is: ' num2str(y)]);
  return
  
  end
