libname cert 'c:\cert\input';
Data cert.input11;
Input name $;
Datalines;
Amanda
Tao
Tao
Chen
Kobe
Chen
Amanda
Tao
Chen
Jordan
Tao
;
Run;
data output11;
set test11std;
by name;
if name in ('AMANDA' 'TAO' 'CHEN') then do;
if first.name then count=0;
count = count + 1;
else count = 0;
end;
run;
proc print data = output11;
run;
