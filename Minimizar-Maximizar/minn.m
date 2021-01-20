m = 1000;                                                                 #ZJ
r = [5 15 -1 1 0 0 0 0 50;20 5 0 0 -1 1 0 0 40;15 2 0 0 0 0 -1 1 60; 0 0 0 0 0 0 0 0 0];
            #CJ                 #CJ-ZJ
r2 = [5,2,0, m, 0, m, 0, m;0, 0, 0, 0, 0, 0, 0, 0];
#disp(R2);
v = [m m m];
function [r]= Zj(r,v)
    [f,n] = size(r);
    for j=1: n
      for i=1:f-1
        r(f,j) += r(i,j)*v(i);
      endfor
    endfor
endfunction


function [r2]= cjzj(r2,r)
    [f,c] = size(r);
    r2(2,:) = r2(1,:) - r(f,1:(c-1));
    
endfunction

function [I,M] = Columna_Pivote(r2)
  vector = r2(2,:);  
  [M,I] = min(vector(:));  
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
  [M,l] = min(T(:)); 
  
endfunction

function [v] = actualizarV(r2,C,F,v)
  if(F>length(v))
    F = length(V)
  endif
  v(F) = r2(1,C);
endfunction

function [r] = Uno(r,f,c)
  valor = r(f,c);
  r(f,:) = r(f,:)/valor;
endfunction

function [r] = Ceros(r,f,c);
  [m,n] = size(r);
  
  for i =1: m-1
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


function [] = Main(r,r2,v)
  
  r =Zj(r,v);
  disp(r)
  r2 = cjzj(r2,r);
  fprintf("\n");
  disp(r2);
  fprintf("\n");
  [C,m] = Columna_Pivote(r2);
  
  while (m<0)
    
    F = Fila_Pivote(r,C);
    v = actualizarV(r2,C,F,v);
    fprintf("\n");
    r = Uno(r,F,C);
    r = Ceros(r,F,C);
    disp(r);
  
    fprintf("\n");
    [fi,co] = size(r);
    r(fi,:) = zeros(1,co);
    disp(r);
    fprintf("\n");
    r =Zj(r,v);
    disp(r)
    r2 = cjzj(r2,r);
    fprintf("\n");
    disp(r2);
    fprintf("\n");
    [C,m] = Columna_Pivote(r2);
 
endwhile
  fprintf("\nResultados: \n");
  Salida(r);
endfunction

function [] = Datos()
  printf("")
endfunction
function [] = Salida(r)
  [f,c] = size(r);
  
  printf("z = %f\n", r(f,c));
  for i = 1 : 2
      [M,I] = max(r(1:f-1,i));
      printf("x%d = %f\n",I, r(i,c));
  endfor
endfunction
Main(r,r2,v);


