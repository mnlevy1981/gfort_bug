all: assoc

assoc:
	gfortran assoc.F90

clean:
	rm a.out
