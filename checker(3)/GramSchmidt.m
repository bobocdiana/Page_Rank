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

## GramSchmidt

## Author: Diana <diana@diana-SATELLITE>
## Created: 2014-04-13

function [B] = GramSchmidt (A)
    % Functia care calculeaza inversa matricei A folosind factorizari Gram-Schmidt

    %Formarea matricelor Q si R care au propietatea ca A=Q*R   
    [n n]=size(A);
    R=zeros(n);
    Q=eye(n);
    R(1,1)=norm(A(:,1));
    Q(:,1)=A(:,1)/R(1,1);
    for p=1:n
        for i=1:p-1
            R(i,p)=Q(:,i)'*A(:,p);
        end
        s=zeros(n,1);
        for i=1:p-1
            s=s+R(i,p)*Q(:,i);
        end
        aux=A(:,p)-s;
        R(p,p)=norm(aux);
        Q(:,p)=aux/R(p,p);
    end
    
    %Rezolvarea sistemului Tx(i)=e(i) si formarea matricei B ale carui coloane sunt x(i)
    I=eye(n);
    B=zeros(n);
    for i=1:n
        b=Q'*I(:,i);
        B(n,i)=b(n)/R(n,n);
        for j=n-1:-1:1
            B(j,i)=( b(j)-R(j,j+1:n)*B(j+1:n,i) )/R(j,j);
        end
    end
endfunction
