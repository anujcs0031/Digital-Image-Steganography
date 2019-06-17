clc;
disp('Implementation of RSA Algorithm');
clear all; close all;
p = input('\nEnter the value of p: ');
q = input('\nEnter the value of q: ');
[Pk,Phi,d,e] = intialize(p,q);

 
message=imread('watermarked.bmp'); 
msg= imresize(message,[64 64]);
heightm=size(msg,1);	%Height
widthm=size(msg,2);
estart_time=cputime;

Mm=size(message,1);%Height 
display(Mm);

Nm=size(message,2);%Width 
display(Nm);
%watermark1(1,64)=bitget(message(1,64),8);
%display(watermark1(1,512));

Decrypted_image=msg;   
array = [];
store=0;
store1=0;
store2=0;
c=0;
c1=0;
c2=0;
kk=1;
kkk=1;
jjj=2;
decipher1=0;
for ii = 1:Mm     
for jj = 1:2:Nm  
    
    store1=0;
    store2=0;
    z1=32768;
    z2=16384;
    z3=8192;
    z4=4096;
    z5=2048;
    z6=1024;
    z7=512;
    z8=256;
    watermark1(ii,jj)=bitget(message(ii,jj),8);  
    if(watermark1(ii,jj)==1)
        g1=z1;
    else
        g1=0;
    end
    
    watermark2(ii,jj)=bitget(message(ii,jj),7);
     if(watermark2(ii,jj)==1)
        g2=z2;
    else
        g2=0;
    end
    watermark3(ii,jj)=bitget(message(ii,jj),6); 
     if(watermark3(ii,jj)==1)
        g3=z3;
    else
        g3=0;
    end
    watermark4(ii,jj)=bitget(message(ii,jj),5);
     if(watermark4(ii,jj)==1)
        g4=z4;
    else
        g4=0;
    end
    watermark5(ii,jj)=bitget(message(ii,jj),4); 
     if(watermark5(ii,jj)==1)
        g5=z5;
    else
        g5=0;
    end
    watermark6(ii,jj)=bitget(message(ii,jj),3); 
     if(watermark6(ii,jj)==1)
        g6=z6;
    else
        g6=0;
    end
    watermark7(ii,jj)=bitget(message(ii,jj),2); 
     if(watermark7(ii,jj)==1)
        g7=z7;
    else
        g7=0;
    end
    watermark8(ii,jj)=bitget(message(ii,jj),1);
     if(watermark8(ii,jj)==1)
        g8=z8;
    else
        g8=0;
    end
    
    store1=g1+g2+g3+g4+g5+g6+g7+g8;
    %uint16(z1*watermark1(ii,jj))+uint16(z2*watermark2(ii,jj))+uint16(z3*watermark3(ii,jj))+uint16(z4*watermark4(ii,jj))+uint16(z5*watermark5(ii,jj))+uint16(z6*watermark6(ii,jj))+uint16(z7*watermark7(ii,jj))+uint16(z8*watermark8(ii,jj));
    for s1= 0:65536
        if store1==s1
            c1=s1;
            break;
        end
    end
    %display(store1);
     %display(c1);
    %jj=jj+2;
    
    watermark9(ii,jjj)=bitget(message(ii,jjj),8);  
    watermark10(ii,jjj)=bitget(message(ii,jjj),7);
    watermark11(ii,jjj)=bitget(message(ii,jjj),6);
    watermark12(ii,jjj)=bitget(message(ii,jjj),5);
    watermark13(ii,jjj)=bitget(message(ii,jjj),4); 
    watermark14(ii,jjj)=bitget(message(ii,jjj),3);
    watermark15(ii,jjj)=bitget(message(ii,jjj),2); 
    watermark16(ii,jjj)=bitget(message(ii,jjj),1);
    
    
    store2=uint16(128*watermark9(ii,jjj))+uint16(64*watermark10(ii,jjj))+uint16(32*watermark11(ii,jjj))+uint16(16*watermark12(ii,jjj))+uint16(8*watermark13(ii,jjj))+uint16(4*watermark14(ii,jjj))+uint16(2*watermark15(ii,jjj))+uint16(1*watermark16(ii,jjj));
    %display(store2);
    for s2= 0:255
        if store2==s2
            c2=s2;
            break;
        end
    end
    if(jjj==Nm)
        jjj=2;
    else
        jjj=jjj+2;
    end
    
    c=c1+c2;%+uint16(store2);
    %display(c);
    
    str1=de2bi(c,16);
    %display(str1);
    decipher=crypt1(c,Pk,d);
    %display(decipher);
    %decipher1=mod(decipher,256);
    str=de2bi(decipher,16);
    %display(str);
  
    
    
  
   Decrypted_image(ii,kkk)=bitset(Decrypted_image(ii,kkk), 1,str(1));         
   Decrypted_image(ii,kkk)=bitset(Decrypted_image(ii,kkk), 2,str(2));         
   Decrypted_image(ii,kkk)=bitset(Decrypted_image(ii,kkk), 3,str(3));         
   Decrypted_image(ii,kkk)=bitset(Decrypted_image(ii,kkk), 4,str(4));
   Decrypted_image(ii,kkk)=bitset(Decrypted_image(ii,kkk), 5,str(5));         
   Decrypted_image(ii,kkk)=bitset(Decrypted_image(ii,kkk), 6,str(6));         
   Decrypted_image(ii,kkk)=bitset(Decrypted_image(ii,kkk), 7,str(7));         
   Decrypted_image(ii,kkk)=bitset(Decrypted_image(ii,kkk), 8,str(8)); 
   
 
    
   if kkk==widthm
       
       kkk=1;
      
   else
       kkk=kkk+1;
   
   end
  
   

   
    
    
    
end
end
ielapsed_time=cputime-estart_time;
ielapsed_time
imwrite(Decrypted_image,'Decrypted_watermarked.bmp','bmp'); 
figure(4) 
imshow(Decrypted_image,[]) 
title('Watermarked Image') 
