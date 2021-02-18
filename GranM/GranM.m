m = 1000;                                                           
r = [3,1,0,0,1,0,3;4,3,-1,0,0,1,6;1,1,0,1,0,0,3,;-4,-1,0,0,-m,-m,0];
      
  #disp(R2);
v = [m m 0 1];

function [] = titulos()
  
  fprintf("\n--------------------------------------------------------------------------------------------\n");
  fprintf("           x_1          x_2         x_3          x_4          A_1           A2           R\n");
  fprintf("--------------------------------------------------------------------------------------------\n");
endfunction  
titulos();
disp(r);  
function [r]= Zj(r,v)
    [f,n] = size(r);
    for j=1: n
      for i=1:f-1
        r(f,j) += r(i,j)*v(i);
      endfor
    endfor
endfunction

function [I,M] = Columna_Pivote(r)
  [f,c] = size(r);
  vector = r(f,:);  
  [M,I] = max(vector(1:c-1));
endfunction

function [l] = Fila_Pivote(r,C)
  x = r(1:3,C);
  T = r(1:3,length(r));
  
  for i = 1 : length(T)
    if(x(i)==0)
      T(i) = 0;
    else
      if(x(i) < 0)
        T(i) = 100;
       else
        T(i) = T(i)/(x(i));
       endif
    endif
  endfor
 
  [M,l] = min(T(1:length(T)-1)); 
endfunction

function [r] = Uno(r,f,c)
  valor = r(f,c);
  r(f,:) = r(f,:)/valor;
endfunction

function [r] = Ceros(r,f,c);
  [m,n] = size(r);
  
  for i =1: m
    if(i ~= f)
      pivote = -r(i,c);
      for j = 1: n
          if( pivote >= 0)
            r(i,j) = pivote*r(f,j) + r(i,j);
          else
            r(i,j) = pivote*r(f,j) + r(i,j);
          endif   
      endfor
    endif
  endfor
endfunction

function [] = main(r,v)
    disp(" ");
   r = Zj(r,v);
   titulos()
   disp(r);
  [C,m] = Columna_Pivote(r);    
   disp(" ");
   while(m>1)
    
    F = Fila_Pivote(r,C);
    
    r = Uno(r,F,C);
    titulos()
    disp(r);
    disp(" ");
    
    r = Ceros(r,F,C);
    titulos()
    disp(r);
    disp(" ");
    
   [C,m] = Columna_Pivote(r);   
  endwhile

  Salida(r)
endfunction
function [] = Salida(r)
  [f,c] = size(r);
  
  printf("z = %f\n", r(f,c));
  for i = 1 : 2
      [M,I] = max(r(1:f-1,i));
      printf("x%d = %f\n",i, r(I,c));
  endfor
endfunction
main(r,v);