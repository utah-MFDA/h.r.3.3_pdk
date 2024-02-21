
pluginname=test
XyceDir=/usr/local/stow/Xyce/7.8-adms
XyceInstDir=${XyceDir}/bin
XyceIncludeDir=${XyceDir}/include
XyceDataDir=${XyceDir}/share
XyceLibexecDir=${XyceDir}/libexec
XyceLibDir=${XyceDir}/lib
xmldir=${XyceDataDir}/xml
INSTALL='/usr/bin/install -c'
CPPFLAGS='-DXyce_NOX_LOCA_SUPPORT -I/usr/local/stow/Trilinos/12.12-serial/include -I/usr/include/suitesparse -I/usr/local/stow/adms/2.3.7/include'
CXXFLAGS='-Wl,-rpath,/../lib -O3'
LDFLAGS='-L/usr/local/stow/Trilinos/12.12-serial/lib  '
CXX='c++'
LIBTOOL=libtool

VA_FILES=$(wildcard *.va)
MODULES=$(patsubst %.va,%,$(VA_FILES))
MODULES_H=$(patsubst %.va, N_DEV_ADMS%.h,$(VA_FILES))
OBJFILES=$(patsubst %.h,%.lo,$(MODULES_H))

all: ${pluginname}.so

${pluginname}_bootstrap.C: ${MODULES_H}
	echo "#include <Xyce_config.h>" >  $@
	echo $(foreach MODULE,$(MODULES),"#include <N_DEV_ADMS"${MODULE}".h>\n") | sed 's/\\n */\n/g' >> $@
	echo "struct Bootstrap ">>   $@
	echo "{">>   $@
	echo "  Bootstrap()" >>   $@
	echo "  {" >>   $@
	echo $(foreach MODULE,$(MODULES),"    Xyce::Device::ADMS${MODULE}::registerDevice();\n")  | sed 's/\\n/\n/g' >> $@
	echo "  }" >>   $@
	echo "};" >>   $@
	echo "Bootstrap s_bootstrap;" >>   $@

N_DEV_ADMS%.C N_DEV_ADMS%.h: %.va
	admsXml -D__XYCE__ -x -e ${xmldir}/adms.implicit.xml \
		-e ${xmldir}/xyceVersion_nosac.xml \
		-e ${xmldir}/xyceBasicTemplates_nosac.xml \
		-e ${xmldir}/xyceAnalogFunction_nosac.xml \
		-e ${xmldir}/xyceHeaderFile_nosac.xml \
		-e ${xmldir}/xyceImplementationFile_nosac.xml $<

%.o %.lo: %.C
	${LIBTOOL} --tag=CXX --mode=compile ${CXX} \
		-I. -I${XyceIncludeDir} \
		${CPPFLAGS} ${CXXFLAGS} \
		-c $< \
		-fPIC -DPIC \
		-o $@

${pluginname}.la ${pluginname}.so: ${pluginname}_bootstrap.lo $(OBJFILES)
	${LIBTOOL} --tag=CXX --mode=link ${CXX} \
		-module -shared \
		-avoid-version ${CXXFLAGS} \
		-fPIC -DPIC ${LDFLAGS} \
		-o ${pluginname}.la \
		-rpath ${XyceLibDir} \
		${OBJFILES} \
		${pluginname}_bootstrap.lo

clean:
	rm -f ${pluginname}_bootstrap.lo ${pluginname}_bootstrap.C ${pluginname}_bootstrap.o
	rm -f N_DEV_ADMS*.C N_DEV_ADMS*.h N_DEV_ADMS*.lo N_DEV_ADMS*.o
	rm -f ${pluginname}.la 	${pluginname}.so
	rm -f .adms*.xml .interface*.xml .*.adms constants.vams disciplines.vams


install: ${pluginname}.la
	${LIBTOOL} --mode=install ${INSTALL} -c ${pluginname}.la "${DESTDIR}"

.PHONEY: install all clean

build_lef:
	cd Components && make build_lef

build_va:
	cd Components && make build_va

build_scad:
	cd Components && make build_scad

