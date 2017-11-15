#include "all.ox"
main() {
	decl k, level,key, menu;
	format(250);
    menu = main_menu();
    level =0;
    do {
	   for (k=0;k<sizeof(menu);++k)
            println("[","%02u",k,"] ",menu[k][prompt]);
 	   scan("[-1]  ", level ? "go to main menu" : "QUIT ","\n?","%i",&k);
	   if (k==QUIT) {
            if (!level)  exit(0);
            --level;
            menu = main_menu();
            }
       else if (k==DOALL) {
            for(k=0;k<sizeof(menu);++k)
                if (isfunction(menu[k][call]))
	               make_the_call(menu,k);
            scan("Press any key and ENTER to continue\n","%2c",&key);
            }
       else if ( isfunction(menu[k][call]) ) {
	       make_the_call(menu,k);
           scan("Press any key  and ENTER to continue\n","%2c",&key);
           }
       else {
            menu = menu[k][submenu]();
            ++level;
            }
    }   while (TRUE);   //user has to enter -1 to QUIT
}
