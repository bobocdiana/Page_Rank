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

## Apartenenta

## Author: Diana <diana@diana-SATELLITE>
## Created: 2014-04-13

function y = Apartenenta (x, val1, val2)
    %Calculul valorii u(x) in functie de intervalul de apartenenta a lui x
    if x<val1
        y=0;
    end
    if x>val2
            y=1;
    end
    if x>=val1 && x<=val2
        y=x/(val2-val1)+val1/(val1-val2);
    end
endfunction
