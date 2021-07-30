file='data.txt';
[A,delimitorOut]=importdata(file);

B=A(:,1);
G=A(:,2);
R=A(:,3);
RGB=[R(:) G(:) B(:)];

train_data=zeros(196045,4);
test_data=zeros(49012,3);

for i=1:196045
   % for y=1:4
        train_data(i,:)=[RGB(i,1),RGB(i,2),RGB(i,3),A(i,4)];
        %train_data(:,4)=A(:,4);
   % end
end

for i=1:49012
    for j=1:3
       % disp(i);
       % disp(i+196045);
       test_data(i,j)=RGB(i+196045,j);
    end
end
fismat=genfis1(train_data,[2 2 2],'gbellmf','linear');
showfis(fismat);
anfis = anfis(train_data,fismat);
%fismat = genfis1(data,numMFs,inmftype,outmftype)
output=evalfis(test_data,anfis);
count=0;
for i=1:length(output)
   if(output(i)>0 && output(i)<=1)
       output(i) = 1;
       
   else
       output(i)=2;
       
   end    
end    

for i=1:length(output)

   if(A(i+196045,4)==output(i))
       count=count+1;
   end
end

accuracy=(count/ length(output))*100;
