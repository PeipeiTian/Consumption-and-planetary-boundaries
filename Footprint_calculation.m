clc;
clear;

Z=xlsread('Z.xlsx',1);
X=xlsread('X.xlsx',1);
  A=zeros(9165,9165);
   for j=1:9165
       for i=1:9165
      if   X(1,j)<0.0001
           A(i,j)=0;
      else
           A(i,j)=Z(i,j)/X(1,j);
      end
        end
   end  

L=eye(9165)-A;

F=xlsread('HANPP.xlsx',1);%Environmental accounts
  i=1;
  E1=zeros(1,9165);
  while i<=9165
    if X(1,i)<0.0001   
       E1(1,i)=0;
    else
       E1(1,i)=F(1,i)/X(1,i);  
    end
       i=i+1;
 end 
  E=diag(E1);

  Y=xlsread('Final_demand_global10_threshold.xlsx',1);%Final demand
  Footprint=E*(L\Y);
  Footprint_sum=sum(Footprint);
  
  
  Footprint_global_decile=zeros(1,10);
    for m=1:10
      Footprint_global_decile(1,m)=Footprint_sum(1,m); 
       for n=1:167
       Footprint_global_decile(1,m)=Footprint_global_decile(1,m)+Footprint_sum(1,m+10*n); 
       end
    end   
 
 
  i=1;
for i=1:168
   Footprint_nation_decile(i,1:10)=Footprint_sum(1,1+10*(i-1):10*i);
end


    Y_global_decile=zeros(9165,50);
   for m=1:10
      Y_global_decile(:,m)=Y(:,m); 
      for n=1:167
      Y_global_decile(:,m)=Y_global_decile(:,m)+Y(:,m+10*n); 
      end
  end

   
    i=1;j=1;
  for i=1:10
      Y_c1=Y(:,i);
      Y_c=diag(Y_c1);
      Footprint_ind3=E*(L\Y_c);
      Footprint_ind2=sum(Footprint_ind3);
      Footprint_ind1(:,i)=Footprint_ind2';
  end
  
  
  

    i=1;j=1;
  for i=1:50
      Y_c1=Y_global_decile(:,i);
      Y_c=diag(Y_c1);
      Footprint_ind3=E*(L\Y_c);
      Footprint_ind2=sum(Footprint_ind3);
      Footprint_ind1(:,i)=Footprint_ind2';
  end

  
    Footprint_ind=zeros(65,10);
   i=1;j=1;
  for i=1:65
      Footprint_ind(i,:)=Footprint_ind1(i,:); 
      for j=1:140
      Footprint_ind(i,:)=Footprint_ind(i,:)+Footprint_ind1(i+65*j,:); 
      end
  end
  
  
 Y_ind=zeros(65,10);
   i=1;j=1;
  for i=1:65
      Y_ind(i,:)=Y(i,:); 
      for j=1:140
      Y_ind(i,:)=Y_ind(i,:)+Y(i+65*j,:); 
      end
  end
  
