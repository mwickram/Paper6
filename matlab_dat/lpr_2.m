
function lpr_2(fname,np,isy,relu)

d=load(fname);
d=sgolayfilt(d,1,61);

rng=10;
ns=1:-1/(np*rng):1/np;

n=length(ns);

for k=1:n
  
dn(:,k)=ns(k)*d(:,1);   
dnft=dn(end,k)

-isy-relu

if dnft< (-isy-relu)    
[row]=find((-isy-relu)<(dn(:,k)) & (dn(:,k))<(-isy+relu));
res=abs(diff(d(:,2)))./abs(diff(dn(:,k)));

LPR(k,1)=mean(res(row));
potl(k,1)=mean(d(row,1));

else 

n=k

end

count(k)=k

switch count
    case  count(1)
R1=res;
    case count(length(count))
        R2=res;
end
 
LPR;

Minimum_LPR=LPR(n)

% figure(1)
% 
% subplot(2,2,1)
% 
% 
% g=plot(d(:,2),dn(:,n),'--k');
% set(g(1),'linewidth',2);
% ylabel('i (mA)'), xlabel('V (mV)')
% 
% subplot(2,2,2)
% 
% 
% plot(dn(2:end,1),R1,'-ok',dn(2:end,n),R2,'--ob')
% xlabel('i (mA)');
% ylabel('R (\Omega)');
% xlim([(-isy-relu) (-isy+relu)]);
% %ylim([LPR(n) LPR(1)])
% title(['LPR of 1 element',  '=' , num2str(LPR(1,1)), '\Omega','  ','@',' ', num2str(isy),' ','mA'])
% legend('1 element',num2str(1/np),'Location','best')
% 
% subplot(2,2,3)
% N=1:n;
% 
% N=wrev(ns(1:n));
% N';
% plot(N, LPR,'-o','markersize',5 )   
% xlabel('# electrodes');ylabel('LPR (\Omega)')
% title(['Minimum LPR',' ','(','1/',num2str(np),' ', 'elements',')',' ','=', num2str(LPR(n)),' ','\Omega'])
% 
% subplot(2,2,4)
% plot(-log10(abs(potl)),LPR,'-o','markersize',5)
% 
% xlabel('log10(V) (mV)');ylabel('LPR (\Omega)') 
% 
% figure (2)
% g=plot(d(:,2),dn(:,1),'-k',d(:,2),dn(:,n),'--k');
% set(g(1),'linewidth',2);
% ylim([(-isy-1) (-isy+1 )])
% xlabel('V (mV)');ylabel('i (mA)');
% legend('One element', 'n^t^ h','location','best')
% 
% 
end



