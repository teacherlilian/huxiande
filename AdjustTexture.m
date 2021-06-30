function Img = AdjustTexture(input)
% used to convert double-texture into uint8-texture.
if(size(input, 3) == 3)
r = input(:, :, 1);
g = input(:, :, 2);
b = input(:, :, 3);
rr = uint8((r-min(min(r)))/(max(max(r))-min(min(r)))*256);
gg = uint8((g-min(min(g)))/(max(max(g))-min(min(g)))*256);
bb = uint8((b-min(min(b)))/(max(max(b))-min(min(b)))*256);
Img(:, :, 1) = rr;
Img(:, :, 2) = gg;
Img(:, :, 3) = bb;

else
    r = input;
    rr = uint8((r-min(min(r)))/(max(max(r))-min(min(r)))*256);
    Img = rr;
end
