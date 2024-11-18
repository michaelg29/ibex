// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include "simple_system_common.h"
#include <stdlib.h>
#include <string.h>
#define NUM_ITERATIONS 10000
#define VECTOR_SIZE 1000

int mul_values(int x, int y){
  return x*y;
}

int div_values(int x, int y){
  return x/y;
}

int main(int argc, char **argv) {
  // pcount_enable(0);
  // pcount_reset();
  // pcount_enable(1);

  // puts("Hello simple system\n");
  // puthex(0xDEADBEEF);
  // putchar('\n');
  // puthex(0xBAADF00D);
  // putchar('\n');

  // pcount_enable(0);

  // Enable periodic timer interrupt
  // (the actual timebase is a bit meaningless in simulation)
  timer_enable(2000);

  
  uint64_t last_elapsed_time = get_elapsed_time();
  
  pcount_enable(0);
  pcount_reset();
  pcount_enable(1);
  double vec1[VECTOR_SIZE] = {};
  double vec2[VECTOR_SIZE] = {};
  double result[VECTOR_SIZE] = {};

  // std::vector<double> vec1(VECTOR_SIZE);
  //   std::vector<double> vec2(VECTOR_SIZE);
  //   std::vector<double> result(VECTOR_SIZE);

    
    for (int i = 0; i < VECTOR_SIZE; ++i) {
        vec1[i] = 1.0 + (i % 10);  // Example pattern: 1.0, 2.0, ..., 10.0, then repeats
        vec2[i] = 2.0 + (i % 5);   // Example pattern: 2.0, 3.0, ..., 6.0, then repeats
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
  for(int a = 0; a <6; a++){
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
  
  for (int i = 0; i < NUM_ITERATIONS; ++i) {
        for (int j = 0; j < VECTOR_SIZE; ++j) {
            result[j] = vec1[j] * vec2[j];
        }
    }
   

    int count[12];
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
    // putchar(count[0]);
    int i = 0;
    char s[20] ={'E', '\n', '\0'};

    for(int j = 0; j < 12; j++){
      i = 0;
      s[0] ='E';
      s[1] = '\n';
      s[2] = '\0';
      if(count[j] != 0){
        while(count[j] > 0){
          s[i] = count[j] %10 + '0';
          count[j] /=10;
          i++;
        }

        for(int k = 0; k < i; k++){
          s[k] = s[i-1-k];
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
