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

## Iterative

## Author: Diana <diana@diana-SATELLITE>
## Created: 2014-04-13

function [R0 A K] = Iterative (nume, d, eps)

    fid=fopen(nume,'r');
    n=fscanf(fid,"%d",1);
    
    %Formarea matricei de adiacenta si a matricei diagonala a gradelor
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
    
    %Tratarea cazului in care nodul i are link catre el insusi
    for i=1:n
        if A(i,i)==1
            A(i,i)=0;
            K(i,i)=K(i,i)-1;
        end
    end
    
    val1=fscanf(fid,"%f",1);
    val2=fscanf(fid,"%f",1);
    fclose(fid);
    
    %Calculul inversei matricei diagonala a gradelor
    invK=zeros(n);
    for i=1:n
        invK(i,i)=1/K(i,i);
    end
    
    %Calculul vectorului R, pornind de la aproximatia initiala R0
    R0(1:n,1)=1/n;
    R=zeros(n,1);
    while 1  
        R=d*(invK*A)'*R0+(1-d)/n*ones(n,1);  
        if abs(R-R0)<eps
            break;
        end
        R0=R;
    end
endfunction
