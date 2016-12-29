
function run_data (file,area,isy,relu)

data=load(file); %file of area 0.008 cm2
data(:,1)=data(:,1)/1;% currrt density 

data= [area*data(:,1) data(:,2)];

find_lpr1(data,isy,relu)

end