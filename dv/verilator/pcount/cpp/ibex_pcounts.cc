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
    "I-$ Component",
    "Branch Prediction Component",
    "D-$ Component",
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

std::string cpi_accumulation(char separator, std::string::size_type longest_name_length, std::string new_counter_cycles, std::string new_counter_cpi, double metrics) {
  std::stringstream pcount_ss;
  int padding = longest_name_length - new_counter_cycles.length();
  pcount_ss << new_counter_cycles << separator;
  for (int j = 0; j < padding; ++j)
    pcount_ss << ' ';
  
  pcount_ss << metrics << std::endl;
  
  pcount_ss << new_counter_cpi << separator;
  
  padding = longest_name_length - new_counter_cpi.length();
  for (int j = 0; j < padding; ++j)
    pcount_ss << ' ';
  
  metrics = (metrics/(mhpmcounter_get(2)*1.0000));
  pcount_ss << std::fixed << std::setprecision(4) << metrics << std::endl;
  return pcount_ss.str();
}

std::string ibex_pcount_string(bool csv) {
  char separator = csv ? ',' : ':';
  std::string::size_type longest_name_length = 0;

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

  if (mhpmcounter_num() >= 3) {
    // observed CPI
    pcount_ss << cpi_accumulation(separator, longest_name_length, "Observed Cycles", "Observed CPI", (double)mhpmcounter_get(0));
    
    // frontend cycles counter from standard counters
    pcount_ss << cpi_accumulation(separator, longest_name_length, "Frontend Cycles (standard)", "Frontend CPI (standard)", (double)mhpmcounter_get(4));
    
    // backend cycles counter from standard counters
    pcount_ss << cpi_accumulation(separator, longest_name_length, "Backend Cycles (standard)", "Backend CPI (standard)", (double)(mhpmcounter_get(3) + mhpmcounter_get(11) + mhpmcounter_get(12)));
    
    // frontend cycles counter from new counters
    pcount_ss << cpi_accumulation(separator, longest_name_length, "Base Cycles (new)", "Base CPI (new)", (double)mhpmcounter_get(13));
    
    // frontend cycles counter from new counters
    pcount_ss << cpi_accumulation(separator, longest_name_length, "Frontend Cycles (new)", "Frontend CPI (new)", (double)(mhpmcounter_get(14) + mhpmcounter_get(15)));
    
    // backend cycles counter from new counters
    pcount_ss << cpi_accumulation(separator, longest_name_length, "Backend Cycles (new)", "Backend CPI (new)", (double)(mhpmcounter_get(16) + mhpmcounter_get(17) + mhpmcounter_get(18)));
  }
  return pcount_ss.str();
}
