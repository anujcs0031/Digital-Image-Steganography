clc;
disp('Implementation of RSA Algorithm');
clear all; close all;
p = input('\nEnter the value of p: ');
q = input('\nEnter the value of q: ');
[Pk,Phi,d,e] = intialize(p,q);

message=imread('lena64.bmp');
msg= imresize(message,[64 128]);
%message=rgb2gray(message);


width=size(msg,2);
estart_time=cputime;

Mm=size(message,1);%Height 
display(Mm);

Nm=size(message,2);%Width 
display(Nm);
%watermark1(1,64)=bitget(message(1,64),8);
%display(watermark1(1,512));

Encrpted_image=msg;   
%Encrpted_image1=message; 
array = [];
store=0;
p=1;
q=2;

for ii = 1:Mm     
for jj = 1:Nm               
    watermark1(ii,jj)=bitget(message(ii,jj),8);  
    watermark2(ii,jj)=bitget(message(ii,jj),7);
    watermark3(ii,jj)=bitget(message(ii,jj),6);
    watermark4(ii,jj)=bitget(message(ii,jj),5);
    watermark5(ii,jj)=bitget(message(ii,jj),4); 
    watermark6(ii,jj)=bitget(message(ii,jj),3);
    watermark7(ii,jj)=bitget(message(ii,jj),2); 
    watermark8(ii,jj)=bitget(message(ii,jj),1);
    store=uint16(128*watermark1(ii,jj))+uint16(64*watermark2(ii,jj))+uint16(32*watermark3(ii,jj))+uint16(16*watermark4(ii,jj))+uint16(8*watermark5(ii,jj))+uint16(4*watermark6(ii,jj))+uint16(2*watermark7(ii,jj))+uint16(1*watermark8(ii,jj));
    for j= 1:255
        if store==j
            c=j;
        end
    end
    str1=de2bi(c,8);
    %display(c);
    cipher=crypt1(c,Pk,e);
    %display(cipher);
    str=de2bi(cipher,16);
   
    %display(str);
    
   
    Encrpted_image(ii,p)=bitset(Encrpted_image(ii,p), 1,str(9));         
    Encrpted_image(ii,p)=bitset(Encrpted_image(ii,p), 2,str(10));         
    Encrpted_image(ii,p)=bitset(Encrpted_image(ii,p), 3,str(11));         
    Encrpted_image(ii,p)=bitset(Encrpted_image(ii,p), 4,str(12));
    Encrpted_image(ii,p)=bitset(Encrpted_image(ii,p), 5,str(13));         
    Encrpted_image(ii,p)=bitset(Encrpted_image(ii,p), 6,str(14));         
    Encrpted_image(ii,p)=bitset(Encrpted_image(ii,p), 7,str(15));         
    Encrpted_image(ii,p)=bitset(Encrpted_image(ii,p), 8,str(16)); 
    Encrpted_image(ii,q)=bitset(Encrpted_image(ii,q), 1,str(1));         
    Encrpted_image(ii,q)=bitset(Encrpted_image(ii,q), 2,str(2));         
    Encrpted_image(ii,q)=bitset(Encrpted_image(ii,q), 3,str(3));         
    Encrpted_image(ii,q)=bitset(Encrpted_image(ii,q), 4,str(4));
    Encrpted_image(ii,q)=bitset(Encrpted_image(ii,q), 5,str(5));         
    Encrpted_image(ii,q)=bitset(Encrpted_image(ii,q), 6,str(6));         
    Encrpted_image(ii,q)=bitset(Encrpted_image(ii,q), 7,str(7));         
    Encrpted_image(ii,q)=bitset(Encrpted_image(ii,q), 8,str(8)); 
    
    if (q==width)
        p=1;
        q=2;
    
    else
    p=p+2;
    q=q+2;
    end
    
    
end
end

ielapsed_time=cputime-estart_time;
ielapsed_time

imwrite(Encrpted_image,'Encrpted_watermarked.bmp','bmp'); 
figure(1) 
imshow(Encrpted_image,[]) 
title('Watermarked Image') 