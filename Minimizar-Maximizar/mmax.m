r = [1 , -200, -300, 0, 0, 0, 0;
     0 ,    1,    1,  1,0, 0,45;
     0 ,    3,    2,  0,1, 0,100;
     0 ,    2,    4,  0,0, 1,120];
     
function [] = titulos()
  fprintf("\n--------------------------------------------------------------------------------------------\n");
  fprintf("            Z           x_1          x_2         s_1          s_2          s_3           R\n");
  fprintf("--------------------------------------------------------------------------------------------\n");
  endfunction     
titulos();   
disp(r);

function [I,M] = Columna_Pivote(vector)
  m = vector(1,:);  
  [M,I] = min(m(:));  
endfunction

function [l] = Fila_Pivote(vector,I)
  x = vector(2:4,I);
  T = vector(2:4,length(vector));
  
  for i = 1 : length(T)
    if(x(i)==0)
      T(i) = 0;
    else
      T(i) = T(i)/x(i);
    endif
  endfor
  
  [M,l] = min(T(:)); 
  l++;
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

function [] = Maximizar(r)
 [I,M] = Columna_Pivote(r);
  l = Fila_Pivote(r,I);
  while(M<0)
  
    r = Uno(r,l,I);
    fprintf('\n');
    titulos();
    disp(r);
    r = Ceros(r,l,I);
    
    [I,M] = Columna_Pivote(r);
    l = Fila_Pivote(r,I);
     
    fprintf('\n');
    titulos();
    disp(r);
   endwhile
   Salida(r);
endfunction

function [] = Salida(r);
  [f,c] = size(r);
  
  [z,zi] = max(r(:,1));
  [x1,x1i] = max(r(:,2));
  [x2,x2i] = max(r(:,3));
  t = r(:,c);
  
  printf("Resultados: \nz = %f\n", t(zi));
  printf("x1 = %f\n", t(x1i));
  printf("x2 = %f", t(x2i));
      
endfunction

Maximizar(r);