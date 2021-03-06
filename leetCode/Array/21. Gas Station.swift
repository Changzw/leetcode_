//
//  21. Gas Station.swift
//  leetCode
//
//  Created by czw on 7/20/20.
//  Copyright © 2020 czw. All rights reserved.
//

import Foundation

/*
 贪心算法，分析数据，找到合适算法 med

 在一条环路上有 N 个加油站，其中第 i 个加油站有汽油 gas[i] 升。
 你有一辆油箱容量无限的的汽车，从第 i 个加油站开往第 i+1 个加油站需要消耗汽油 cost[i] 升。
 你从其中的一个加油站出发，开始时油箱为空。
 
 如果你可以绕环路行驶一周，则返回出发时加油站的编号，否则返回 -1。
 
 说明:
 如果题目有解，该答案即为唯一答案。
 输入数组均为非空数组，且长度相同。
 输入数组中的元素均为非负数。
 
 示例 1:
 输入:
 gas  = [1,2,3,4,5]
 cost = [3,4,5,1,2]
 输出: 3
 解释:
 从 3 号加油站(索引为 3 处)出发，可获得 4 升汽油。此时油箱有 = 0 + 4 = 4 升汽油
 开往 4 号加油站，此时油箱有 4 - 1 + 5 = 8 升汽油
 开往 0 号加油站，此时油箱有 8 - 2 + 1 = 7 升汽油
 开往 1 号加油站，此时油箱有 7 - 3 + 2 = 6 升汽油
 开往 2 号加油站，此时油箱有 6 - 4 + 3 = 5 升汽油
 开往 3 号加油站，你需要消耗 5 升汽油，正好足够你返回到 3 号加油站。 因此，3 可为起始索引。
 
 示例 2:
 输入:
 gas  = [2,3,4]
 cost = [3,4,3]
 输出: -1
 解释:
 你不能从 0 号或 1 号加油站出发，因为没有足够的汽油可以让你行驶到下一个加油站。
 我们从 2 号加油站出发，可以获得 4 升汽油。 此时油箱有 = 0 + 4 = 4 升汽油
 开往 0 号加油站，此时油箱有 4 - 3 + 2 = 3 升汽油
 开往 1 号加油站，此时油箱有 3 - 3 + 3 = 3 升汽油
 你无法返回 2 号加油站，因为返程需要消耗 4 升汽油，但是你的油箱只有 3 升汽油。 因此，无论怎样，你都不可能绕环路行驶一周。
 
 分析：
 gas  = [1,2,3,4,5]
 cost = [3,4,5,1,2]
 1. 先选择一个位置，然后按顺序跑完两个数组
 2. 第一个位置一定是 gas[i] > cost[i]
 3. 然后遍历每个元素，知道找到结果
 */
class GasStation {
  
  func tryStart(_ r: [Int], _ s: Int) -> Int {
    var cur = s
    var t = r[cur]
    while (cur + 1) % r.count != s {
      t += r[(cur + 1) % r.count]
      if t < 0 {
        return -1
      }
      cur = (cur + 1) % r.count
    }
    return s
  }
  
  func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
    var r = gas
    var totalR = 0
    for i in 0..<gas.count {
      r[i] -= cost[i]
      totalR += r[i]
    }
    if totalR < 0 {
      return -1
    }

    for i in 0..<gas.count {
      if r[i] >= 0 {
        let x = tryStart(r, i)
        if x >= 0 {
          return i
        }
      }
    }
    return -1
  }

  func canCompleteCircuit_(_ gas: [Int], _ cost: [Int]) -> Int {
    let len = gas.count
    var spare = 0
    var minSpare = Int.max
    var minIndex = 0
    
    for i in 0..<len {
      spare += gas[i] - cost[i]
      if spare < minSpare {
        minSpare = spare
        minIndex = i
      }
    }
    
    return spare < 0 ? -1 : (minIndex + 1) % len
  }
}


extension GasStation: Algorithm {
  func doTest() {
    performLogCostTime(self.name + " method1") {
      print(canCompleteCircuit([2],
        [2]))
    }
  }
}
