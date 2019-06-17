
stego_image=imread('StegoImage.bmp');
message=imread('2.bmp');     %takin watermarked image and calculating its size
watermark=message;
% determine size
heightm=size(message,1);	%Height
widthm=size(message,2);	%Width
heightc=size(stego_image,1);	%Height
widthc=size(stego_image,2);	%Width

a=0;
b=0;

x=csvread('value.txt',a,b,[a,b,a,b+1]); %reading file for the values to determine upto 
index1=x(1,1);  %which point embedding has been done
index2=x(1,2);  %storing in index1 and index2

count=1;
sum1=0;
sum2=0;
sum3=0;
%array = [];
array  = zeros(16,1);
a=1;
b=1;

ct=0;
ct1=0;

p1=8;
p2=0;

p=1;
q=2;


% use lsb of watermarked image to recover watermark
for ii = 1:heightc
    for jj = 1:widthc
       if(ii==index1 && jj==index2)
         ct1=1;
           break;
       else    
          bit=bitget(stego_image(ii,jj),1);
          %display(bit);
          
          if(count<=8)
           
          %sum1=bit*(power(2,p1));
          %display(sum1);
          if(bit==1)
              if(p1==8)
          array(count)=256;
              elseif(p1==9)
          array(count)=512;
          elseif(p1==10)
          array(count)=1024;
          elseif(p1==11)
          array(count)=2048;
          elseif(p1==12)
          array(count)=4096;
          elseif(p1==13)
          array(count)=8192;
          elseif(p1==14)
          array(count)=16384;
          elseif(p1==15)
          array(count)=32768;
              end
          else
              array(count)=0;
          end
          %display(array);
          %display(p1);
          p1=p1+1;
          
          count=count+1;

          elseif(count>8 && count<=16)
          sum2=bit*(power(2,p2));
          %display(sum2);
          array(count)=sum2;
          %display(array);
          %display(p2);
          p2=p2+1;
          count=count+1;
          
          end
          if((count>16) && a<=heightm)

               sum3=sum(array);
               %display(sum3);
               str=de2bi(sum3,16);
               count=1; 
               sum3=0; 
               array  = zeros(16,1);
                   p1=8;
                   p2=0;  
               
            watermark(a,p)=bitset(watermark(a,p), 1,str(9));         
            watermark(a,p)=bitset(watermark(a,p), 2,str(10));         
            watermark(a,p)=bitset(watermark(a,p), 3,str(11));         
            watermark(a,p)=bitset(watermark(a,p), 4,str(12));
            watermark(a,p)=bitset(watermark(a,p), 5,str(13));         
            watermark(a,p)=bitset(watermark(a,p), 6,str(14));         
            watermark(a,p)=bitset(watermark(a,p), 7,str(15));         
            watermark(a,p)=bitset(watermark(a,p), 8,str(16)); 
            watermark(a,q)=bitset(watermark(a,q), 1,str(1));         
            watermark(a,q)=bitset(watermark(a,q), 2,str(2));         
            watermark(a,q)=bitset(watermark(a,q), 3,str(3));         
            watermark(a,q)=bitset(watermark(a,q), 4,str(4));
            watermark(a,q)=bitset(watermark(a,q), 5,str(5));         
            watermark(a,q)=bitset(watermark(a,q), 6,str(6));         
            watermark(a,q)=bitset(watermark(a,q), 7,str(7));         
            watermark(a,q)=bitset(watermark(a,q), 8,str(8)); 
    
    
                         if (q==widthm)
                            a=a+1;
                            p=1;
                            q=2;
    
                         else
                             p=p+2;
                             q=q+2;
                         end
                         
                      
                         
                         %{
                  if(b==widthm)
                  a=a+1;  %incrementing coordinates in watermark image
                  b=1;
                  
              else
                  b=b+1;
              end 
            %}
             
             %array=0;
          
       
          end
       end
    end
        if(ct1==1)
        break;
        end    
    
end

fptr=fopen('img2.txt','wt');
fprintf(fptr,'%d,%d\n',watermark); %writing watermark to a file just for checking purposes
fclose(fptr);
imwrite(watermark,'watermarked.bmp','bmp');
figure(3);    
imshow(watermark,[]);
title('Extracted Message');


