## Copyright (C) 2014 Diana
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## PageRank

## Author: Diana <diana@diana-SATELLITE>
## Created: 2014-04-13

function [ R1 R2 ] = PageRank (nume, d, eps)

    R1=Iterative(nume, d, eps)

    R2=Algebraic(nume, d)

    % Citire a valorilor val1 si val2 sin fisierul de intrare
    fid=fopen(nume,'r');
    aux=fscanf(fid,"%f");
    val1=aux(length(aux)-1);
    val2=aux(length(aux));
    fclose(fid);
    
    nume=strcat(nume,'.out');
    n=length(R2);
    fid=fopen(nume,'w');
    fprintf(fid,"%d\n",n);
    for i=1:n
        fprintf(fid,"%f \n",R1(i));
    end
    fprintf(fid,"\n");
    for i=1:n
        fprintf(fid,"%f \n",R2(i));
    end
    
    % Ordonarea descrescatoare a vectorului R2
    index=[1:n];
    for i=1:n-1
        for j=i+1:n
            if R2(i)<R2(j)
                aux=R2(i);
                R2(i)=R2(j);
                R2(j)=aux;
                aux=index(i);
                index(i)=index(j);
                index(j)=aux;
            end
            if norm(R2(i)-R2(j))<eps*norm(R2(j))
                aux=R2(i);
                R2(i)=R2(j);
                R2(j)=aux;
                aux=index(i);
                index(i)=index(j);
                index(j)=aux;
            end
        end
    end
    index
    
    fprintf(fid,"\n");
    for i=1:n
        u=Apartenenta(R2(i),val1,val2);
        fprintf (fid,"%d %d %f \n",i,index(i),u);
    end
    fclose(fid);
endfunction
