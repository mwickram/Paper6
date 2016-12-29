function curr_lpr(file,n,relu)


d=load(file);


df=find(d(:,1)<0);

d=d(df,:);

for k=1:n
dn(:,k)=k*d(:,1);
end

d=[dn d(:,2)];

max_curr=max(dn(:,end));
min_curr=min(dn(:,1));

isy= -0.05:-0.01:-0.5;

for k=1:length(isy)
    
[LPR(:,k)]=lpr(d,n,-isy(k),relu,0);

end



figure(10)


plot(isy,LPR)


end