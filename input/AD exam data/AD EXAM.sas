libname cert 'c:\cert\input\AD exam data\input';
libname results 'c:\cert\output';

options mprint mlogic;

options cmplib=work.function

%macro col1;
name age;
%mend;

%macro col2;
height weight;
%mend;

Lab1.
proc sql; 
create table work.sql02 as 
   select Prodtype, Product 
      from cert.prdsal2 
   union 
   select Prodtype, Product 
      from cert.prdsal3 
   order by Prodtype desc 
; 
select * from work.sql02; 
quit; 


proc print data=cert.prdsal2(obs=10 firstobs=1);
run;

proc print data=cert.prdsal3(obs=10 firstobs=1);
run;

Lab2.
proc sql;
select * into: col_list seperated by ','  from dictionary.columns
where libname='CERT' and memname="AIR10"; 
quit;

Lab3.
proc sql;
select Species,mean(weight) as avgweight from cert.fish13
group by species 
having avgweight >(select median(weight) from cert.fish13);
quit;

proc sql;
select sum(avgweight) from
(select Species,mean(weight) as avgweight from cert.fish13
group by species 
having avgweight >(select median(weight) from cert.fish13))a ; 
quit;

Lab4.
proc sql;
create table work.sql19 as
select gender,age,mean(height) as avgheight format=6.2 from cert.class19
group by gender,age
having avgheight > 60
order by gender,age;
quit;

%macro combo03;
data work.combined03;
set 
%do i = 1 %to 100;
cert.data&i
%end;
;
run;
%mend;

%combo03;

proc contents data=combined03;
run;

proc print data=cert.mac_in07;
run;

data work.combined03;
do i = 1 to 100;
set
set cert.data%eval(&i);
output;
end;
drop i;
run;

data work.mac07;
set cert.mac_in07;
call symputx('fname',name);
run;

%put &fname;

%include 'c:\cert\input\exam data\input\macro18.sas'

options mprint;
%cars18(Asia,Europe)

option cmplib=work.functions;
proc fcmp outlib=work.functions.dev;
function reversename (name $) $ 40;
return (catx(" ", scan(name,2,","),scan(name,1,",")));
endsub;
quit;
data work.act01;
set cert.names01;
newname=reversename(name);
run;

proc print data=act01 (firstobs=28 obs=28);
run;

proc print data=cert.division22;
run;


lab10.
data work.act22;
length league division $10;
if _n_ = 1 then do;
call missing(League);
call missing(Division);
declare hash D(dataset: 'cert.division22');
D.definekey('div');
D.definedata('League','Division');
D.definedone();
end;
set cert.teams22;
D.find();
run;

proc contents data=cert.salary20;
run;

proc print data=work.act22;
where team='Boston';
var div;
run;

lab12.
data work.act20;
set cert.salary20;
array incs (5) income1-income5;
array new  (5) (80000 81000 82000 83000 84000);
do i = 1 to 5;
if incs(i)<new(i) then incs(i)=new(i);
end;
run;

proc means data=work.act20;
var Income1;
run;
