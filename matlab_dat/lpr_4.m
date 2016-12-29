
function lpr_4(fname,n,isy,ised,relu,sel)

d=load(fname);
d=sgolayfilt(d,1,61);
    
if sel==1
lpr_1(fname,n,isy,relu)

else    
       
for k=1:n 
dn(:,k)=k*d(:,1);
res=abs(diff(d(:,2)))./abs(diff(dn(:,k)));

isy=dn(end,1):0.01:ised;

for fk=1:100
row=find((-isy(fk)-relu)<(dn(:,k)) & (dn(:,k))<(-isy(fk)+relu));

LPR(fk,k)=mean(res(row));

end

%res=abs(diff(d(:,2)))./abs(diff(dn(:,k)));


%LPR(k,1)=mean(res(row));    
potl(k,1)=mean(d(row,1));

switch k
    case  1
R1=res;

    case n
        R2=res;
end

figure(1)

end

LPR;
Minimum_LPR=LPR(n)

figure(1)

subplot(2,2,1)


g=plot(d(:,2),dn(:,1),'-k',d(:,2),dn(:,n),'--k');
set(g(1),'linewidth',2);
ylabel('i (mA)'), xlabel('V (mV)')

subplot(2,2,2)


plot(dn(2:end,1),R1,'-ok',dn(2:end,n),R2,'--ob')
xlabel('i (mA)');
ylabel('R (\Omega)');
%xlim([(-isy-relu) (-isy+relu)]);
%ylim([LPR(n) LPR(1)])
title(['LPR of 1 element',  '=' , num2str(LPR(1,1)), '\Omega','  ','@',' ', num2str(isy),' ','mA'])
legend('1 element',num2str(n),'Location','best')

subplot(2,2,3)
N=1:n;
N';
plot(N, LPR,'-o','markersize',5 )   
xlabel('# electrodes');ylabel('LPR (\Omega)')
title(['Minimum LPR',' ','(',num2str(n),' ', 'elements',')',' ','=', num2str(LPR(n)),' ','\Omega'])

subplot(2,2,4)
plot(-log10(abs(potl)),LPR,'-o','markersize',5)

xlabel('log10(V) (mV)');ylabel('LPR (\Omega)') 

figure (2)
g=plot(d(:,2),dn(:,1),'-k',d(:,2),dn(:,n),'--k');
set(g(1),'linewidth',2);
%ylim([(-isy-1) (-isy+1 )])
xlabel('V (mV)');ylabel('i (mA)');
legend('One element', 'n^t^ h','location','best')
end
end



