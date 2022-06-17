import Foundation

let data = readLine()!.split(separator: " ").map { Int(String($0))! }
let M = data[0]     // 가로
let N = data[1]     // 세로

var isCompleted = true         // 안익은 토마토 개수
var queue: [(Int, Int)] = []    // 익은 토마토 좌표
var queueFront = 0

// 토마토 정보 입력
var box: [[Int]] = []
for row in 0..<N {
    let line = readLine()!.split(separator: " ").map { Int(String($0))! }
    box.append(line)
    
    for (idx, value) in line.enumerated() {
        if value == 0 {
            isCompleted = false
        } else if value == 1 {
            queue.append((idx, row))
        }
    }
    
}

// 토마토가 모두 익어있는 경우 0 출력
if isCompleted {
    print(0)
} else {
    
    let direction = [(1,0), (-1,0), (0,-1), (0,1)]  // 상하좌우 좌표 offset
    
    var time = -1   // 1회차 경우를 빼 주어야 하므로 -1
    while queue.count > queueFront {
        
        time += 1

        // 주변을 익게 만들 토마토 모두 진행
        for _ in queueFront..<queue.count {
            
            let current = queue[queueFront]
            queueFront += 1
            
            // 상하좌우 토마토 익힌다
            for direction in direction {
                
                let x = current.0 + direction.0
                let y = current.1 + direction.1
                
                // 새로운 칸이 박스를 벗어나지 않는다면
                if (0..<M).contains(x) && (0..<N).contains(y) {
                    if box[y][x] == 0 {
                        box[y][x] = 1
                        queue.append((x, y))
                    }
                }
            }
        }
    }
    
    for row in box {
        if row.contains(0) {
            time = -1
        }
    }
    
    print(time)
}
