clear all  

%% initialisation
cover=imread('Baboon.bmp');  %readind cover and messsage images
message=imread('Encrpted_watermarked.bmp');
%message=rgb2gray(message);

%heightc=size(cover,1);
widthc=size(cover,2);
                                %calculating size of cover and message
heightm=size(message,1); 
widthm=size(message,2);

fptr=fopen('img1.txt','wt');
fprintf(fptr,'%d,%d\n',message);  %writing original message in a file just for checking purposes
fclose(fptr);


p=1;
q=1;
count=1;
%display(message);
%% Embedding in LSB    %using scrambled message for embedding
stego_image=cover;
for ii = 1:heightm
    for jj = 1:widthm
        while count<=8
            bit=bitget(message(ii,jj),count);  %in this process for each (ii,jj)
            count=count+1;                     %retriving all 8 bits for ii,jj and
            stego_image(p,q)=bitset(stego_image(p,q),1,bit); % then storing it in consecutive
            if(q==widthc)             %LSB's of the cover image so that each pixel in message
                p=p+1;                %takes 8 LSB's in cover image so take the cover of Appropriate
                q=1;                  %size so that whole message can be embedded in cover image
            else
                q=q+1;
            end    
        end
        count=1;
    end
end


%% Creating and displaying
imwrite(stego_image,'StegoImage.bmp','bmp');
fid=fopen('value.txt','wt');
fprintf(fid,'%d,%d\n',p,q);  %and the point ii,jj upto which message has been embedded
fclose(fid);                 %in cover image is written to a file so that it can be 
figure(2)                  %retrieved on another file ArnoldEx
imshow(stego_image,[])
title('Stego Image')

