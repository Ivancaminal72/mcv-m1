function [prob] = HistogramBackpropagation(h, point)
  % h is the histogram object
  % point is a 1/2 element vector with the colors

  if size(point, 1) == 1
    % 1d histogram

    be = h.BinEdges;
    pos = 1;
    for i=1:size(be,2)-1
      if point >= be(i) && point <= be(i+1)
        pos = i;
      end
    end

    prob = h.Values(pos);

  else
    % 2d histogram
    be_x = h.XBinEdges;
    be_y = h.YBinEdges;
    point_x = point(1);
    point_y = point(2);

    pos_x = 1;
    pos_y = 1;

    for i=1:size(be_x,2)-1
      if point_x >= be_x(i) && point_x <= be_x(i+1)
        pos_x = i;
      end
    end
    for i=1:size(be_y,2)-1
      if point_y >= be_y(i) && point_y <= be_y(i+1)
        pos_y = i;
      end
    end

    prob = h.Values(pos_x, pos_y);
  end
end