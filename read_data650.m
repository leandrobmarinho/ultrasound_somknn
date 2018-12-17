% 650
retr_4M_650 = load('temperature - 650C/Backscattered/Transdutor 4 MHz/retr_4M_625_000h.dat');
retr_4M_650 = [retr_4M_650; load('temperature - 650C/Backscattered/Transdutor 4 MHz/retr_4M_625_650C_010h.dat')];
retr_4M_650 = [retr_4M_650; load('temperature - 650C/Backscattered/Transdutor 4 MHz/retr_4M_625_650C_100h.dat')];
retr_4M_650 = [retr_4M_650; load('temperature - 650C/Backscattered/Transdutor 4 MHz/retr_4M_625_650C_200h.dat')];

retr_5M_650 = load('temperature - 650C/Backscattered/Transdutor 5 MHz/retr_5M_625_000h.dat');
retr_5M_650 = [retr_5M_650; load('temperature - 650C/Backscattered/Transdutor 5 MHz/retr_5M_625_650C_010h.dat')];
retr_5M_650 = [retr_5M_650; load('temperature - 650C/Backscattered/Transdutor 5 MHz/retr_5M_625_650C_100h.dat')];
retr_5M_650 = [retr_5M_650; load('temperature - 650C/Backscattered/Transdutor 5 MHz/retr_5M_625_650C_200h.dat')];

ecos_4M_650 = load('temperature - 650C/echos/Transdutor 4 MHz/ecos4_4M_625_000h.dat');
ecos_4M_650 = [ecos_4M_650; load('temperature - 650C/echos/Transdutor 4 MHz/ecos4_4M_625_650C_010h.dat')];
ecos_4M_650 = [ecos_4M_650; load('temperature - 650C/echos/Transdutor 4 MHz/ecos4_4M_625_650C_100h.dat')];
ecos_4M_650 = [ecos_4M_650; load('temperature - 650C/echos/Transdutor 4 MHz/ecos4_4M_625_650C_200h.dat')];

ecos_5M_650 = load('temperature - 650C/echos/Transdutor 5 MHz/ecos4_5M_625_000h.dat');
ecos_5M_650 = [ecos_5M_650; load('temperature - 650C/echos/Transdutor 5 MHz/ecos4_5M_625_650C_010h.dat')];
ecos_5M_650 = [ecos_5M_650;load('temperature - 650C/echos/Transdutor 5 MHz/ecos4_5M_625_650C_100h.dat')];
ecos_5M_650 = [ecos_5M_650;load('temperature - 650C/echos/Transdutor 5 MHz/ecos4_5M_625_650C_200h.dat')];


classes_retr_650 = [];
classes_ecos_650 = [];
for i = 1:4
    classes_retr_650 = [classes_retr_650; repmat(i, size(retr_4M_650,1)/4, 1)];
    classes_ecos_650 = [classes_ecos_650; repmat(i, size(ecos_4M_650,1)/4, 1)];
end