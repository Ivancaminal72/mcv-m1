function [h] = PlotYHist(f,c,i, A, bins, name)
  subplot(f,c,i);
  A = A(:,1);
  h = histogram(A(:), bins, 'Normalization', 'pdf');
  title(name); % axis([0, 255, 0, 40000]);
end