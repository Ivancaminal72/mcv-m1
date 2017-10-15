function [pdf] = get_pdf(A, bins)
  if(size(A,2) == 1)
    A = double(A);
    h = histogram(A(:,1), bins, 'Normalization', 'pdf');
    % pdf = imresize(h.Values, [255, 255]);
    pdf = h.Values;
  else
    A = double(A);
    h = histogram2(A(:,1), A(:,2), bins, 'Normalization', 'pdf');
    % pdf = imresize(h.Values, [255, 255]);
    pdf = h.Values;
  end
end

