FC=gfortran

all: test

test: clean
	$(FC) assoc.F90
	$(FC) --version
	./a.out

clean:
	rm -f a.out assoc.o

