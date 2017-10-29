function [op]=MorphologicalTransform(mask_in)
  sq2=strel('square',2); 
  ds2=strel('disk',2); 
  ds10=strel('disk',10);

  mask=imfill(mask_in,'holes');
  er=imerode(mask,ds2);
  er=imerode(er,ds2);

  di=imdilate(er,sq2);
  di=imdilate(di,sq2);

  op=imopen(di,ds10);
end