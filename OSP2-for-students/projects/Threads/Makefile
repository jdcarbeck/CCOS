SOURCES=ThreadCB.java TimerInterruptHandler.java	
NONPRE=ThreadCB_NONPRE.java TimerInterruptHandler.java
PREQUE=ThreadCB_PREQUE.java TimerInterruptHandler.java
CLASSES=osp/*/*.class
OPTS=

all: build

build: $(CLASSES)
	@(test -d osp/tmp || \
		(mkdir -p osp/tmp; make) \
		|| (echo "Something wrong: Can't create the directory for the *.class files"; exit 1))


$(CLASSES): $(SOURCES) 
	javac -g -classpath .:$(CLASSPATH):OSP.jar -d . $(SOURCES)

nonpre: $(NONPRE)
	javac -g -classpath .:$(CLASSPATH):OSP.jar -d . $(NONPRE)

preque: $(PREQUE)
	javac -g -classpath .:$(CLASSPATH):OSP.jar -d . $(NONPRE)

run: 	build
	java -classpath .:$(CLASSPATH):OSP.jar osp.OSP -noGUI $(OPTS)

gui: 	build
	java -classpath .:$(CLASSPATH):OSP.jar osp.OSP $(OPTS)

demo:
	java -classpath .:$(CLASSPATH):Demo.jar osp.OSP $(OPTS)

debug: 	build
	jdb -classpath .:$(CLASSPATH):OSP.jar osp.OSP $(OPTS)

clean:
	/bin/rm -rf osp temp *.log saved
