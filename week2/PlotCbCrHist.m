function [h] = PlotCbCrHist(f,c,i, A, bins)
  subplot(f,c,i)
   % [counts, centers] = hist3(a, [bins,bins]);
  A = double(A);
  h = histogram2(A(:,2), A(:,3), bins, 'Normalization', 'pdf');
  title (strcat(int2str(bins), ' bins')); %axis([0, 255, 0, 40000])
end
