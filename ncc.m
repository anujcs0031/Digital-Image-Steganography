function m = ncc(w1, w2)
w1=imread('lena64.bmp');
w2=imread('Decrypted_watermarked.bmp');
w1 = w1 - mean(w1(:));
	w2 = w2 - mean(w2(:));

	x = sqrt( sum(sum(w1.^2))*sum(sum(w2.^2)) );

	if x < 1e-10,
		m = 0;
	else
		m = sum(sum((w1.*w2))) / x;
    end
    
   
    
    disp('ZNCC for watermark:');
    disp(m);
    
end
