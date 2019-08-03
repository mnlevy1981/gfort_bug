FC=gfortran

all: test

test:
	rm -f a.out
	$(FC) assoc.F90
	$(FC) --version
	./a.out

