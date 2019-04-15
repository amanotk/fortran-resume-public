#!/usr/bin/env python
# -*- coding: utf-8 -*-

fn = "helix2.dat"

try:
    # use numpy/scipy if available
    import numpy as np
    import scipy as sp
    from scipy import io

    # open file in fortran unformatted binary mode
    fp = io.FortranFile(fn, "r")

    # read x
    x  = fp.read_record(np.float64)

    # read y
    y  = fp.read_record(np.float64)

    # read z
    z  = fp.read_record(np.float64)

except:
    # instead pure python implementation
    import array

    # prepare array objects
    x  = array.array('d')
    y  = array.array('d')
    z  = array.array('d')

    # open file in binary read mode
    fp = file(fn, "rb")

    # x
    h  = fp.read(4)
    x.fromfile(fp, 32)
    f  = fp.read(4)

    # y
    h  = fp.read(4)
    y.fromfile(fp, 32)
    f  = fp.read(4)

    # z
    h  = fp.read(4)
    z.fromfile(fp, 32)
    f  = fp.read(4)

# array size
N = len(x)

# print
for i in range(N):
    print("%5.2f %5.2f %5.2f" % (x[i], y[i], z[i]))
