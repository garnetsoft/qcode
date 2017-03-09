quote:flip `time`sym`bid`ask!()

/ table to hold active and inactive connection information
handle:1!flip `h`active`user`host`address`time!"ibss*p"$\:()

/ record new client connection
.z.po:{[h]`handle upsert (h;1b;.z.u;.Q.host .z.a;"i"$0x0 vs .z.a;.z.P);}
.z.po 0i / simulate opening of 0

/ mark client connection as inactive
.z.pc:{[h]`handle upsert `h`active`time!(h;0b;.z.P);}


upd:{[arg]
 / show arg;
 
 t:arg[0];                   /saves the table name to t
 x:arg[1];                   /saves the data received to x
 show t;
 show x;
 z:(count x)#.z.T;           /creates a list with current time (time of receiving x)
 t insert (enlist z),flip x; /insert time and data into t
 }

/ q)`:anyfilename.csv 0: "," 0: table 
/ q)`:tmp/ADP_DATA.csv 0: "," 0:(select from t where sym=`ADP)
/ `:tmp/ADP_DATA.csv

saveDailyFile:{[t;s;p]
 fname:`$"_" sv (string s;"DATA.csv");
 fpath:`$"/" sv (p;string fname);
 show string fpath;
 fpath 0: "," 0:t;
 }
 
upd2:{[t;x]
 / show t;
 / show x;
 z:(count x)#.z.T;           /creates a list with current time (time of receiving x)
 t insert (enlist z),flip x; /insert time and data into t;
 
 / publish to listeners - incremental updates 
 / d:select by sym 
 
 }
 
sub:{[t;k]

 }
 
pub:{[h]

 }

 
/ create a saved file for sym
/ "." sv (`$"data/",string sym; "csv");
save2file:{[t]
 syms: exec sym from t;
 {data:select from t where sym=x; show "saving...",string x ;"." sv (`$"data/",string x; "csv")} each syms; 
 }
 
/ {data:select from quote where sym=x; show "saving...",string x;`$ "." sv ("data/",string x; "csv")} each `AAPL`GOOGL`YHOO

dirs:{(`sv x,) each key[x] except `q`Q`h`j`o}