function [wc] = SlidingWindow(mask, da, im)
    
end


% Feature computation
% Marc stuff.


% Filling ratio of Week 1
      % filling_ratio = FillingRatio(mask(ann.y:ann.y+ann.h-1,ann.x:ann.x+ann.w-1), ann.w, ann.h);

% function fr = FillingRatio(signal, w, h)
%     % The nnz function counts the number of non zero values of the matrix
%     fr = nnz(signal)/(w*h);
% end

%%% Filling ratio
% Arguments:
%   1. struct 'coords' with .x, .y, .w, .h

% 1. For loop
function [fr] = FillingRatio_simple(mask, coords)
  content_bb = mask(coords.y:coords.y+coords.h-1,coords.x:coords.x+coords.w-1);
  S = nnz(content_bb)  
  fr =  S /(coords.w*coords.h);
end

% 2. Integral Image
function [fr] = FillingRatio_IntegralImage(mask, coords, ii)

  % Convert from x,y,w,z to 4 coordinates (x,y)
  a_coord = [coords.y+coords.h-1, coords.x+coords.w-1];
  b_coord = [coords.y, coords.x+coords.w-1] ;
  c_coord = [coords.y+coords.h-1, coords.x] ;
  d_coord = [coords.y, coords.x];

  % Find coordenades (x,y) of points a,b,c,d
  d_coord = d_coord - [1,1];
  b_coord = b_coord - [1,0];
  c_coord = c_coord - [0,1];

  % Careful, if the bounding box is touching a border
  % the corresponding part is equal to 0

  A=0;B=0;C=0;D=0;
  if a_coord(1) ~= 0 && a_coord(2) ~= 0
    A = ii(a_coord(1), a_coord(2));  
  end
  if b_coord(1) ~= 0 && b_coord(2) ~= 0
    B = ii(b_coord(1), b_coord(2));  
  end
  if c_coord(1) ~= 0 && c_coord(2) ~= 0
    C = ii(c_coord(1), c_coord(2));  
  end
  if d_coord(1) ~= 0 && d_coord(2) ~= 0
    D = ii(d_coord(1), d_coord(2));  
  end

  % Sum
  S = A - B - C + D

  % Filling ratio
  fr = S/(coords.w*coords.h);
end

%% IntegralImage: Calculate the image integral
function [ii] = IntegralImage(im)
  ii = cumsum(cumsum(im,2));
end
