/* -*- C -*- */
#include <stdio.h>

int main()
{
  const int N = 10;

  int i;
  double x[N];
  FILE *fp;

  // open
  fp = fopen("cbinary.dat", "w");

  if( fp == NULL ) {
    printf("Failed to open file\n");
    return -1;
  }

  // write data
  for(int i=0; i < N; i++) {
    x[i] = i * 0.5 + 1.0;
  }

  fwrite(x, sizeof(double), N, fp);

  // close
  fclose(fp);

  return 0;
}

