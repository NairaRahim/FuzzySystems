%image=imread('image.png');
%A=imread('skinit.jpg');
%%YCbCr=rgb2ycbcr(image);
%%imshow(YCbCr);

fis=readfis('fuzzy.fis');

%%Y=evalfis(YCbCr,fis);
%%Y = evalfis(YCbCr,fis);
%%R=YCbCr(:,:,1);
file='data.txt';
[A,delimitorOut]=importdata(file);
%C=unique(A,'rows');
B=A(:,1);
G=A(:,2);
R=A(:,3);
RGB=[R(:) G(:) B(:)];

result=zeros(length(A),3);
for i=1: length(RGB)
    row=convrgb2y(RGB(i,:));
    result(i,:)=row';
end

count1=0;%nonskin
count2=0;%skin
% for i=1:length(result)
%    if((result(i,1)>a) && (result(i,2)>b) && (result(i,3)>c))
%        result(i,:)=result(i,:);
%    else
%        result(i,:)=[16,128,128];
%    end
%        
% end 

output = evalfis(result,fis);

for i=1:length(output)
   if(output(i)>0 && output(i)<=1)
       output(i) = 1;
       %count1=count1+1;
   else
       output(i)=2;
       %count2=count2+1;
   end    
end    

for i=1:length(A)

   if(A(i,4)==output(i))
       count1=count1+1;
   end
end

accuracy=(count1/ length(A))*100;
