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

## Algebraic

## Author: Diana <diana@diana-SATELLITE>
## Created: 2014-04-13

function [ R ] = Algebraic (nume, d)
    % Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
    % Intrari:
    % -> nume: numele fisierului in care se scrie;
    % -> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
    % Iesiri:
    % -> R: vectorul de PageRank-uri acordat pentru fiecare pagina.


    %Extragerea informatiilor din fisierul de intrare si formarea matricei de adiacenta
    % si a matricei diagonala a gradelor
    fid=fopen(nume,'r');
    n=fscanf(fid,"%d",1);
    A=zeros(n);
    K=zeros(n);
    for i=1:n
        p=fscanf(fid,"%d",1);
        K(p,p)=fscanf(fid,"%d",1);
        for j=1:K(p,p)
            x=fscanf(fid,"%d",1);
            A(p,x)=1;
        end
    end
    for i=1:n
        if A(i,i)==1
            A(i,i)=0;
            K(i,i)=K(i,i)-1;
        end
    end
    val1=fscanf(fid,"%f",1);
    val2=fscanf(fid,"%f",1);
    fclose(fid);
    
    %Inversarea matricei diagonala a gradelor
    invK=zeros(n);
    for i=1:n
        invK(i,i)=1/K(i,i);
    end
    
    %Calculul inversei matricei eye(n)-d*M
    B=GramSchmidt(eye(n)-d*(invK*A)');
    %Calculul vectorului R cand t->infinit
    R=B*(1-d)/n*ones(n,1);
endfunction
