#include "all.ox"
enum{QUIT=-1,DOALL,CHOICE}
make_the_call(m,k);
main() {
	decl k, level,done, nx = 1, r,i,menu;
	format(250);
    menu = tests;
    level =0;
    do {
	   for (k=0;k<sizeof(menu);++k)
            println("[","%02u",k,"] ",menu[k][prompt]);
 	   scan("[-1]  QUIT\n?","%i",&k);
	   if (k==QUIT) {
            if (!level)  exit(0);
            --level;
            menu = tests;
            }
       else if (k==DOALL) {
            for(k=0;k<sizeof(menu);++k)
                if (isfunction(menu[k][call])
	               make_the_call(menu,k);
            }
       else if ( (done = isfunction(menu[k][call]) )) {
	       make_the_call(menu,k);
           }
       else menu = menu[k][call];
       }
	 } while (!done);
    }

make_the_call(m,k) {
	fopen(m[k][prompt]+".txt","l");
	println("Output of ",m[k][prompt],sep);
	m[k][call]();
    println("... finished.\n");
    }
