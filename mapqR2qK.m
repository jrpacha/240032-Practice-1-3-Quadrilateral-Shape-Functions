clearvars 
close all

%Vertexs of the quadrilateral QK, onto which the reference quadrilateral,QR 
%is mapped
quadK = [
   2,1;
   7,-1;
   6,5;
   3,4
    ]; %vertexs of the quadrilateral K
 
%Call the function qR2qK, that draws the quads. QR, QK, allows the user 
%to select the point to map and drag it and its image through the plane
qR2qK(quadK)

