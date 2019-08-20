## About

When testing a [new pull request](https://github.com/marbl-ecosys/MARBL/pull/338) for MARBL, I had [TravisCI tests fail](https://travis-ci.org/marbl-ecosys/MARBL/builds/567023996) because changing the number of MARBL instances changed answers (it was bit-for-bit on my laptop). I traced the problem to [a specific type of `associate` statement](https://github.com/marbl-ecosys/MARBL/blob/10409e9dc6bd1c7650238304a5dec2811737f169/src/marbl_co2calc_mod.F90#L417). Specifically, associate statements of the form

```
associate(col => mat_type(:)%a)
```

where `a` is a scalar element, results in `col` referring to contiguous memory being rather than having a proper stride to refer to each element `a`.

It looks like this issue was fixed by `gfortran` version 4.9, but setting up Travis to build with a newer `gfortran` while also linking to the netCDF library is non-trivial.

### GFORTRAN 4.8 (netbook)

This version of the compiler has issues with [Keith's bug](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68546) (as seen by the last row in section 1) as well as a new bug that appears to be fixed in later versions (as seen by the last three entries in the second row).
```
$ gfortran --version
GNU Fortran (Ubuntu 4.8.5-4ubuntu8~14.04.2) 4.8.5
Copyright (C) 2015 Free Software Foundation, Inc.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0          10          20

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0          10          20
 pass associated column to function expecting dimension(:)
           0          10          20
 pass associated column to function expecting dimension(3)
           0          10          20
```

### GFORTRAN 4.9 (netbook)

This version of the compiler has issues with [Keith's bug](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68546) but the problems seen in the second section with v4.8 have been resolved.

```
$ gfortran-4.9 --version
GNU Fortran (Ubuntu 4.9.4-2ubuntu1~14.04.1) 4.9.4
Copyright (C) 2015 Free Software Foundation, Inc.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0          10          20

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2
```

### GFORTRAN 5 (netbook)

This version of the compiler has issues with [Keith's bug](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68546) but the problems seen in the second section with v4.8 have been resolved.

```
$ gfortran-5 --version
GNU Fortran (Ubuntu 5.5.0-12ubuntu1~14.04) 5.5.0 20171010
Copyright (C) 2015 Free Software Foundation, Inc.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0          10          20

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2
```

### GFORTRAN 6 (netbook)

This version of the compiler has issues with [Keith's bug](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68546) but the problems seen in the second section with v4.8 have been resolved.

```
$ gfortran-6 --version
GNU Fortran (Ubuntu 6.5.0-2ubuntu1~14.04.1) 6.5.0 20181026
Copyright (C) 2017 Free Software Foundation, Inc.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0          10          20

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2
```

### GFORTRAN 7 (netbook)

This version of the compiler has issues with [Keith's bug](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68546) but the problems seen in the second section with v4.8 have been resolved.

```
$ gfortran-7 --version
GNU Fortran (Ubuntu 7.4.0-1ubuntu1~14.04~ppa1) 7.4.0
Copyright (C) 2017 Free Software Foundation, Inc.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0          10          20

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2
```

### GFORTRAN 8 (netbook)

This version of the compiler has issues with [Keith's bug](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68546) but the problems seen in the second section with v4.8 have been resolved.

```
$ gfortran-8 --version
GNU Fortran (Ubuntu 8.3.0-16ubuntu3~14.04.2) 8.3.0
Copyright (C) 2018 Free Software Foundation, Inc.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0          10          20

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2
```

### GFORTRAN 9 (netbook)

This version of the compiler has issues with [Keith's bug](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68546) but the problems seen in the second section with v4.8 have been resolved. Given the date that the bug was closed, I would have expected all entries to be `0 1 2` with this version.

```
$ gfortran-9 --version
GNU Fortran (Ubuntu 9.1.0-2ubuntu2~14.04.2) 9.1.0
Copyright (C) 2019 Free Software Foundation, Inc.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0          10          20

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2
```

### GFORTRAN 9.2 (work laptop)

This version of the compiler has issues with [Keith's bug](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=68546) but the problems seen in the second section with v4.8 have been resolved. Given the date that the bug was closed, I would have expected all entries to be `0 1 2` with this version as well.

```
$ gfortran --version
GNU Fortran (Homebrew GCC 9.2.0) 9.2.0
Copyright (C) 2019 Free Software Foundation, Inc.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0          10          20

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2
```

### IFORT 16 (hobart)

This compiler behaves as expected

```
$ ifort --version
ifort (IFORT) 16.0.2 20160204
Copyright (C) 1985-2016 Intel Corporation.  All rights reserved.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2
```

### IFORT 17 (hobart)

This compiler behaves as expected

```
$ ifort --version
ifort (IFORT) 17.0.4 20170411
Copyright (C) 1985-2017 Intel Corporation.  All rights reserved.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2
```

### IFORT 18 (hobart)

This compiler behaves as expected

```
$ ifort --version
ifort (IFORT) 18.0.3 20180410
Copyright (C) 1985-2018 Intel Corporation.  All rights reserved.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
           0           1           2
 print the associate column
           0           1           2
 pass associated column to function expecting dimension(:)
           0           1           2
 pass associated column to function expecting dimension(3)
           0           1           2
```

### PGI 18.1 (hobart)

This compiler behaves as expected

```
$ pgf90 --version

pgf90 18.1-1 64-bit target on x86-64 Linux -tp nehalem 
PGI Compilers and Tools
Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
            0            1            2
 print the associate column
            0            1            2
 pass associated column to function expecting dimension(:)
            0            1            2
 pass associated column to function expecting dimension(3)
            0            1            2

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
            0            1            2
 print the associate column
            0            1            2
 pass associated column to function expecting dimension(:)
            0            1            2
 pass associated column to function expecting dimension(3)
            0            1            2
```

### PGI 18.10 (hobart)

This compiler behaves as expected

```
$ pgf90 --version

pgf90 18.10-0 64-bit target on x86-64 Linux -tp nehalem 
PGI Compilers and Tools
Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
            0            1            2
 print the associate column
            0            1            2
 pass associated column to function expecting dimension(:)
            0            1            2
 pass associated column to function expecting dimension(3)
            0            1            2

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
            0            1            2
 print the associate column
            0            1            2
 pass associated column to function expecting dimension(:)
            0            1            2
 pass associated column to function expecting dimension(3)
            0            1            2
```

### PGI 19.4 (work laptop)

This compiler behaves as expected

```
$ pgf90 --version

pgf90 19.4-0 64-bit target on macOS -tp haswell 
PGI Compilers and Tools
Copyright (c) 2019, NVIDIA CORPORATION.  All rights reserved.
```

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
            0            1            2
 print the associate column
            0            1            2
 pass associated column to function expecting dimension(:)
            0            1            2
 pass associated column to function expecting dimension(3)
            0            1            2

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
            0            1            2
 print the associate column
            0            1            2
 pass associated column to function expecting dimension(:)
            0            1            2
 pass associated column to function expecting dimension(3)
            0            1            2
```

### NAG 6.1 (hobart)

This compiler behaves as expected

```
$ ./a.out
 (1) Associate pointing to non-contiguous memory in a 3x3 matrix
 print a column of a matrix
 0 1 2
 print the associate column
 0 1 2
 pass associated column to function expecting dimension(:)
 0 1 2
 pass associated column to function expecting dimension(3)
 0 1 2

 (2) Associate pointing to scalar element in an array of derived type
 print an array of derived-type elements
 0 1 2
 print the associate column
 0 1 2
 pass associated column to function expecting dimension(:)
 0 1 2
 pass associated column to function expecting dimension(3)
 0 1 2
```