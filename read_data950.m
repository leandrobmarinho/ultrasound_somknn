% 950
ecos_4M_950 = load('temperature - 950C/ecos/Transdutor 4 MHz/ecos_4MHz_0h.dat');
ecos_4M_950 = [ecos_4M_950; load('temperature - 950C/ecos/Transdutor 4 MHz/ecos_4MHz_950C_10h.dat')];
ecos_4M_950 = [ecos_4M_950; load('temperature - 950C/ecos/Transdutor 4 MHz/ecos_4MHz_950C_100h.dat')];
ecos_4M_950 = [ecos_4M_950; load('temperature - 950C/ecos/Transdutor 4 MHz/ecos_4MHz_950C_200h.dat')];

ecos_5M_950 = load('temperature - 950C/ecos/Transdutor 5 MHz/ecos_5MHz_0h.dat');
ecos_5M_950 = [ecos_5M_950; load('temperature - 950C/ecos/Transdutor 5 MHz/ecos_5MHz_950C_10h.dat')];
ecos_5M_950 = [ecos_5M_950; load('temperature - 950C/ecos/Transdutor 5 MHz/ecos_5MHz_950C_100h.dat')];
ecos_5M_950 = [ecos_5M_950; load('temperature - 950C/ecos/Transdutor 5 MHz/ecos_5MHz_950C_200h.dat')];

retr_4M_950 = load('temperature - 950C/retroespalhado/Transdutor 4 MHz/retr_4MHz_0h.dat');
retr_4M_950 = [retr_4M_950; load('temperature - 950C/retroespalhado/Transdutor 4 MHz/retr_4MHz_950C_10h.dat')];
retr_4M_950 = [retr_4M_950; load('temperature - 950C/retroespalhado/Transdutor 4 MHz/retr_4MHz_950C_100h.dat')];
retr_4M_950 = [retr_4M_950; load('temperature - 950C/retroespalhado/Transdutor 4 MHz/retr_4MHz_950C_200h.dat')];

retr_5M_950 = load('temperature - 950C/retroespalhado/Transdutor 5 MHz/retr_5MHz_0h.dat');
retr_5M_950 = [retr_5M_950; load('temperature - 950C/retroespalhado/Transdutor 5 MHz/retr_5MHz_950C_10h.dat')];
retr_5M_950 = [retr_5M_950; load('temperature - 950C/retroespalhado/Transdutor 5 MHz/retr_5MHz_950C_100h.dat')];
retr_5M_950 = [retr_5M_950; load('temperature - 950C/retroespalhado/Transdutor 5 MHz/retr_5MHz_950C_200h.dat')];

classes_retr_950 = [];
classes_ecos_950 = [];
for i = 0:3
    classes_retr_950 = [classes_retr_950; repmat(i, size(retr_4M_950,1)/4, 1)];
    classes_ecos_950 = [classes_ecos_950; repmat(i, size(ecos_4M_950,1)/4, 1)];
end
