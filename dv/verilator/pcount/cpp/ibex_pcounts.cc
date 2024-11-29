// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include <numeric>
#include <sstream>
#include <string>
#include <vector>
#include <svdpi.h>
#include <iomanip>

extern "C" {
extern unsigned int mhpmcounter_num();
extern unsigned long long mhpmcounter_get(int index);
}

#include "ibex_pcounts.h"

// see mhpmcounter_incr signals in rtl/ibex_cs_registers.sv for details
// const std::vector<std::string, std::vector<int>> ibex_extra_counter = {
//     // {"Cycles", {0}},
//     // {"NONE", {1}},
//     // {"Instructions Retired", {2}},
//     // {"LSU Busy", {3}},
//     // {"Fetch Wait", {4}},
//     // {"Loads", {5}},
//     // {"Stores", {6}},
//     // {"Jumps", {7}},
//     // {"Conditional Branches", {8}},
//     // {"Taken Conditional Branches", {9}},
//     // {"Compressed Instructions", {10}},
//     // {"Multiply Wait", {11}},
//     // {"Divide Wait", {12}},
//     {, {4}},
//     {"Backend Cycles", {3, 11, 12}}
//     };

const std::vector<std::string> ibex_counter_names = {
    "Cycles",
    "NONE",
    "Instructions Retired",
    "LSU Busy",
    "Fetch Wait",
    "Loads",
    "Stores",
    "Jumps",
    "Conditional Branches",
    "Taken Conditional Branches",
    "Compressed Instructions",
    "Multiply Wait",
    "Divide Wait", 
    "Base Component", 
    "ICache Component",
    "Branch Prediction Component",
    "Dcache Component",
    "Execution Component",
    "Dependency Component"};

static bool has_hpm_counter(int index) {
  // The "cycles" and "instructions retired" counters are special and always
  // exist.
  if (index == 0 || index == 2)
    return true;

  // The "NONE" counter is a placeholder. The space reserves an index that was
  // once the "MTIME" CSR, but now is unused. Return false: there's no real HPM
  // counter at index 1.
  if (index == 1)
    return false;

  // Otherwise, a counter exists if the index is strictly less than
  // the MHPMCounterNum parameter that got passed to the
  // ibex_cs_registers module.
  return index < mhpmcounter_num();
}

std::string ibex_pcount_string(bool csv) {
  char separator = csv ? ',' : ':';
  std::string::size_type longest_name_length;

  if (!csv) {
    longest_name_length = 0;
    for (int i = 0; i < ibex_counter_names.size(); ++i) {
      if (has_hpm_counter(i)) {
        longest_name_length =
            std::max(longest_name_length, ibex_counter_names[i].length());
      }
    }

    // Add 1 to always get at least once space after the separator
    longest_name_length++;
  }

  std::stringstream pcount_ss;
  int count;
  for (int i = 0; i < ibex_counter_names.size(); ++i) {
    if (!has_hpm_counter(i))
      continue;

    pcount_ss << ibex_counter_names[i] << separator;

    if (!csv) {
      int padding = longest_name_length - ibex_counter_names[i].length();

      for (int j = 0; j < padding; ++j)
        pcount_ss << ' ';
    }
    // if(i == 11)
    //   count = pcount_get_mul();
    // else if(i == 12)
    //    count = pcount_get_mul();
    // else
      count = mhpmcounter_get(i);
    pcount_ss << count << std::endl;
  }

 if(mhpmcounter_num() >= 3){
    //new frontend cycles counter
    std::string new_counter;
    int padding;
    double metrics = 0.0;

    new_counter = "Frontend Cycles";
    pcount_ss << new_counter << separator;
   
    padding = longest_name_length - new_counter.length();
    for (int j = 0; j < padding; ++j)
      pcount_ss << ' ';

    pcount_ss << mhpmcounter_get(4) << std::endl;

    //new backend cycles counter
    new_counter = "Backend Cycles";
    pcount_ss << new_counter << separator;
   
    padding = longest_name_length - new_counter.length();
    for (int j = 0; j < padding; ++j)
      pcount_ss << ' ';

    int one = mhpmcounter_get(3);
    int two = mhpmcounter_get(11);
    int three = mhpmcounter_get(12);

    metrics = one + two + three;
    pcount_ss << metrics  << std::endl;

    //new frontend_cpi counter
    new_counter = "Frontend CPI";
    pcount_ss << new_counter << separator;
   
    padding = longest_name_length - new_counter.length();
    for (int j = 0; j < padding; ++j)
      pcount_ss << ' ';
    
    metrics = (mhpmcounter_get(4)/(mhpmcounter_get(2)*1.0000));
    pcount_ss << std::fixed << std::setprecision(4) << metrics  << std::endl;

     //new backend_cpi counter
    new_counter = "Backend CPI";
    pcount_ss << new_counter << separator;
   
    padding = longest_name_length - new_counter.length();
    for (int j = 0; j < padding; ++j)
      pcount_ss << ' ';
    
    metrics = ((mhpmcounter_get(3) + mhpmcounter_get(11) + mhpmcounter_get(12))/(mhpmcounter_get(2)*1.0000));
    // uint32_t div = 0;
    // DEV_READ(0xB8B,div);
    uint32_t div = 0;
    // asm volatile("csrr 0x320, %02;\n" : "=r"(div));
    pcount_ss << std::fixed << std::setprecision(4) << metrics  << std::endl;

    // new_counter = "Base Component";
    // pcount_ss << new_counter << separator;
   
    // padding = longest_name_length - new_counter.length();
    // for (int j = 0; j < padding; ++j)
    //   pcount_ss << ' ';
    
    // metrics = ((mhpmcounter_get(3) + mhpmcounter_get(11) + mhpmcounter_get(12))/(mhpmcounter_get(2)*1.0000));
    // // uint32_t div = 0;
    // // DEV_READ(0xB8B,div);
    // uint32_t div = 0;
    // // asm volatile("csrr 0x320, %02;\n" : "=r"(div));
    // pcount_ss << std::fixed << std::setprecision(4) << metrics  << std::endl;

 }
  return pcount_ss.str();
}
