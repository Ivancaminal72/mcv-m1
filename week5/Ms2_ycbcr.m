function [Ims Kms] = Ms2_ycbcr(I,bandwidth)

%% color + spatial (option: bandwidth)
I = I(:,:,1:2);
I = im2double(I);
[x,y] = meshgrid(1:size(I,2),1:size(I,1)); 
L = [y(:)/max(y(:)),x(:)/max(x(:))]; % Spatial Features
C = reshape(I,size(I,1)*size(I,2),2);
 X = [C,L];  % Color & Spatial Features

%% MeanShift Segmentation
[clustCent,point2cluster,clustMembsCell] = MeanShiftCluster(X',bandwidth);      % MeanShiftCluster
for i = 1:length(clustMembsCell)                                                % Replace Image Colors With Cluster Centers
X(clustMembsCell{i},:) = repmat(clustCent(:,i)',size(clustMembsCell{i},2),1); 
end
Ims = reshape(X(:,1:2),size(I,1),size(I,2),2);                                  % Segmented Image

I_res = ones(size(I,1), size(I,2), 3);
I_res(:,:,:) = 10;
I_res(:,:,1:2) = Ims;
Ims = I_res;
Kms = length(clustMembsCell);

end