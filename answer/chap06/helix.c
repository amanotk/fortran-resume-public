/* -*- C -*- */
#include <stdio.h>

int main()
{
  const int N = 32;
  const char fn[] = "helix2.dat";

  int i, header, footer;
  double x[N], y[N], z[N];
  FILE *fp;

  fp = fopen(fn, "r");

  if( fp == NULL ) {
    printf("Failed to open file\n");
    return -1;
  }

  //
  // *Most* fortran compilers generate a code such that each fortran `write'
  // statement add header and footer before and after the actual data. Usually
  // the header and footer are 4 byte integers that describe the size of
  // data. However, this is not a fortran standard and the behavior may differ
  // in general.
  //

  // -*- read x -*-

  // read 4 byte integer as header
  fread(&header, sizeof(4), 1, fp);

  // read N double precision data
  fread(x, sizeof(double), N, fp);

  // read 4 byte integer as footer
  fread(&footer, sizeof(4), 1, fp);

  // same thing for y
  fread(&header, sizeof(4), 1, fp);
  fread(y, sizeof(double), N, fp);
  fread(&footer, sizeof(4), 1, fp);

  // same thing for z
  fread(&header, sizeof(4), 1, fp);
  fread(z, sizeof(double), N, fp);
  fread(&footer, sizeof(4), 1, fp);

  fclose(fp);

  // output
  for(int i=0; i < N ;i++) {
    printf("%5.2f %5.2f %5.2f\n", x[i], y[i], z[i]);
  }

  return 0;
}
