// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include <stdlib.h>
#include <string.h>

#include "simple_system_common.h"
#define NUM_ITERATIONS 10000
#define VECTOR_SIZE 1000

// void convert_string(int count, char *s) {
//   int i = 0;
//   for (int j = 0; j < 12; j++) {
//     i = 0;
//     s[0] = 'E';
//     s[1] = '\n';
//     s[2] = '\0';
//     if (count != 0) {
//       while (count > 0) {
//         s[i] = count % 10 + '0';
//         count /= 10;
//         i++;
//       }

//       for (int k = 0; k < i; k++) {
//         s[k] = s[i - 1 - k];
//       }

//       s[i] = '\n';
//       i++;
//       s[i] = '\0';
//     }
//   }
// }

int main(int argc, char **argv) {
  timer_enable(2000);

  
  uint64_t last_elapsed_time = get_elapsed_time();
  
  pcount_enable(0);
  pcount_reset();
  pcount_enable(1);
  double vec1[VECTOR_SIZE] = {};
  double vec2[VECTOR_SIZE] = {};
  double result[VECTOR_SIZE] = {};

  pcount_enable(0);
  pcount_reset();
  pcount_enable(1);
  int vec1[VECTOR_SIZE];
  int vec2[VECTOR_SIZE];
  int result[VECTOR_SIZE];

  // std::vector<double> vec1(VECTOR_SIZE);
  //   std::vector<double> vec2(VECTOR_SIZE);
  //   std::vector<double> result(VECTOR_SIZE);

  for (int i = 0; i < VECTOR_SIZE; ++i) {
    vec1[i] =1 + (i % 10);  // Example pattern: 1.0, 2.0, ..., 10.0, then repeats
    vec2[i] = 2 + (i % 5);  // Example pattern: 2.0, 3.0, ..., 6.0, then repeats
  }

  // double curr = 400;
  // curr = curr / 4;
  // curr = curr / 7;
  // curr = curr / 3;
  // curr = curr / 2;
  //  curr = curr / 4;
  // curr = curr / 7;
  // curr = curr / 3;
  // curr = curr / 2;
  //  curr = curr / 4;
  // curr = curr / 7;
  // curr = curr / 3;
  // curr = curr / 2;
  //  curr = curr / 4;
  // curr = curr / 7;
  // curr = curr / 3;
  // curr = curr / 2;

  // double big = 4000*32.56777;

  // for(int i = 0; i < 100000; i ++){
  //   mynum[i] = mynum[i] + 2*i;
  // }

  // asm volatile("wfi");

  // putchar(count[0]);
  for (int a = 0; a < 6; a++) {
    while (last_elapsed_time <= 40) {
      uint64_t cur_time = get_elapsed_time();
      if (cur_time != last_elapsed_time) {
        last_elapsed_time = cur_time;
        // i = i%10000;
        if (last_elapsed_time & 1) {
          puts("Tick!\n");
          // mynum[i] = mul_values(mynum[i] , 2*i);
        } else {
          puts("Tock!\n");
          // mynum[i] = mul_values(mynum[i] , 2*i);
        }

        //       i++;
      }
      //
    }


    int i = 0;
    char st[30];
      for (int j = 0; j < VECTOR_SIZE; ++j) {
        result[j] = vec1[j] * vec2[j];
        int count = result[j];
        i = 0;
        st[0] = 'E';
        st[1] = '\n';
        st[2] = '\0';
        if (count != 0) {
          while (count > 0) {
            st[i] = count % 10 + '0';
            count /= 10;
            i++;
          }

          for (int k = 0; k < i; k++) {
            st[k] = st[i - 1 - k];
          }

          st[i] = '\n';
          i++;
          st[i] = '\0';
        }
        puts(st);
      }

    int count[18];
    asm volatile("csrr %0, 0xB00;" : "=r"(count[0]));
    asm volatile("csrr %0, minstret;" : "=r"(count[1]));
    asm volatile("csrr %0, mhpmcounter3;" : "=r"(count[2]));
    asm volatile("csrr %0, mhpmcounter4;" : "=r"(count[3]));
    asm volatile("csrr %0, mhpmcounter5" : "=r"(count[4]));
    asm volatile("csrr %0, mhpmcounter6;" : "=r"(count[5]));
    asm volatile("csrr %0, mhpmcounter7;" : "=r"(count[6]));
    asm volatile("csrr %0, mhpmcounter8;" : "=r"(count[7]));
    asm volatile("csrr %0, mhpmcounter9;" : "=r"(count[8]));
    asm volatile("csrr %0, mhpmcounter10;" : "=r"(count[9]));
    asm volatile("csrr %0, mhpmcounter11;" : "=r"(count[10]));
    asm volatile("csrr %0, mhpmcounter12;" : "=r"(count[11]));
    asm volatile("csrr %0, mhpmcounter13;" : "=r"(count[12]));
    asm volatile("csrr %0, mhpmcounter14;" : "=r"(count[13]));
    asm volatile("csrr %0, mhpmcounter15;" : "=r"(count[14]));
    asm volatile("csrr %0, mhpmcounter16;" : "=r"(count[15]));
    asm volatile("csrr %0, mhpmcounter17;" : "=r"(count[16]));
    asm volatile("csrr %0, mhpmcounter18;" : "=r"(count[17]));
    // putchar(count[0]);
     i = 0;
    char s[30];
    for (int j = 0; j < 18; j++) {
      i = 0;
      s[0] = 'E';
      s[1] = '\n';
      s[2] = '\0';
      if (count[j] != 0) {
        while (count[j] > 0) {
          s[i] = count[j] % 10 + '0';
          count[j] /= 10;
          i++;
        }

        for (int k = 0; k < i; k++) {
          s[k] = s[i - 1 - k];
        }

        s[i] = '\n';
        i++;
        s[i] = '\0';
      }
      puts(s);
    }
  }
  pcount_enable(0);
  asm volatile("wfi");
  return 0;
}
