function [BW,maskedImage] = segmentImage(RGB)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(RGB) segments image RGB using
%  auto-generated code from the Image Segmenter app. The final segmentation
%  is returned in BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 03-Nov-2023
%----------------------------------------------------


% Convert RGB image into L*a*b* color space.
X = rgb2lab(RGB);

% Create empty mask
BW = false(size(X,1),size(X,2));

% Draw ROIs

xPos = [308.5023 307.2229 296.3485 295.0692 294.4295 286.1137 286.1137 286.7534 289.3121 289.3121 289.3121 289.3121 289.3121 289.3121 291.2311 291.8708 291.8708 289.3121 289.3121 289.3121 289.3121 291.2311 291.8708 293.1501 294.4295 304.6642 307.2229 308.5023 318.0974 320.0164 321.2957 326.4131 327.6924 346.2429 346.8826 349.4413 350.0810 350.7207 353.2793 378.8662 378.8662 378.8662 379.5059 383.9836 384.6233 384.6233 385.2630 385.9026 394.8581 396.7771 396.7771 398.0564 398.6961 401.2548 403.1738 403.8135 403.8135 404.4531 408.2912 409.5705 414.0482 414.0482 414.6879 417.8863 419.8053 424.2830 425.5623 426.2020 426.8417 427.4813 429.4004 430.0400 431.9591 453.0682 455.6269 472.2584 477.3758 481.2138 509.9991 512.5578 525.3512 527.9099 535.5860 533.0273 531.7480 529.1893 528.5496 522.1529 519.5942 517.0355 516.3958 516.3958 515.1165 515.1165 515.1165 515.1165 513.1975 513.1975 513.1975 513.1975 512.5578 506.8007 506.1611 506.1611 506.1611 506.1611 506.1611 506.1611 506.1611 505.5214 505.5214 505.5214 503.6024 499.7643 494.0073 484.4122 481.2138 478.6551 478.0155 464.5823 463.9427 462.6633 462.0237 460.7443 451.1492 447.9509 446.6715 446.0318 446.0318 430.6797 428.7607 423.6433 394.2184 391.6597 388.4613 387.1820 385.2630 367.9918 362.2348 359.6761 346.8826 344.3239 337.2875 337.2875 336.0082 334.0892 332.8098 311.7006 307.7013 307.2987];
yPos = [131.2571 131.2571 131.2571 131.2571 131.8965 148.5209 149.1603 149.1603 166.4240 169.6210 170.2604 190.7212 193.2788 195.1970 211.1820 211.8214 213.1002 219.4942 220.7730 222.6912 223.9699 227.1669 227.8063 229.0851 229.0851 229.0851 229.0851 229.0851 229.0851 229.0851 229.0851 229.0851 229.0851 231.0033 231.0033 231.0033 231.0033 231.0033 231.0033 241.2337 240.5943 239.9549 238.6761 238.0367 238.6761 239.9549 240.5943 240.5943 243.1519 244.4307 245.0701 246.3489 246.9883 248.2671 249.5459 250.1853 249.5459 249.5459 249.5459 249.5459 250.8247 251.4641 251.4641 254.6611 254.6611 257.8581 257.8581 257.8581 257.8581 259.1369 259.1369 259.1369 259.1369 262.3339 262.3339 262.9733 262.9733 262.9733 262.9733 262.9733 262.3339 262.3339 251.4641 250.1853 248.2671 246.3489 245.0701 228.4457 223.9699 218.2154 218.2154 216.2972 206.0668 204.7880 199.0334 198.3940 176.6544 176.0150 174.0968 170.2604 169.6210 147.2421 147.2421 145.9633 145.3239 144.6845 144.0451 142.7663 142.1269 140.8481 139.5693 138.9299 138.9299 140.8481 142.1269 144.6845 145.3239 145.9633 145.9633 145.9633 145.9633 145.3239 145.3239 145.3239 145.3239 145.3239 145.3239 145.3239 144.6845 142.7663 142.1269 140.8481 129.3389 129.3389 128.6995 128.6995 128.0601 128.0601 126.1419 125.5025 125.5025 126.1419 126.7813 126.1419 126.1419 126.1419 126.7813 131.2571 129.7013 129.2987];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;

xPos = [14.8926 14.8926 39.8399 39.8399];
yPos = [358.8831 371.0317 371.0317 358.8831];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;

% Create masked image.
maskedImage = RGB;
maskedImage(repmat(~BW,[1 1 3])) = 0;
end
