# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=btver2 -timeline -timeline-max-iterations=3 -register-file-stats < %s | FileCheck %s

xor %rsi, %rsi
add %rcx, %rcx
add %rcx, %rcx
add %rcx, %rcx
add %rcx, %rcx
mov %esi, %ecx

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      600
# CHECK-NEXT: Total Cycles:      304
# CHECK-NEXT: Total uOps:        600

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    1.97
# CHECK-NEXT: IPC:               1.97
# CHECK-NEXT: Block RThroughput: 3.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      0     0.50                        xorq	%rsi, %rsi
# CHECK-NEXT:  1      1     0.50                        addq	%rcx, %rcx
# CHECK-NEXT:  1      1     0.50                        addq	%rcx, %rcx
# CHECK-NEXT:  1      1     0.50                        addq	%rcx, %rcx
# CHECK-NEXT:  1      1     0.50                        addq	%rcx, %rcx
# CHECK-NEXT:  1      1     0.50                        movl	%esi, %ecx

# CHECK:      Register File statistics:
# CHECK-NEXT: Total number of mappings created:    800
# CHECK-NEXT: Max number of mappings used:         12

# CHECK:      *  Register File #1 -- JFpuPRF:
# CHECK-NEXT:    Number of physical registers:     72
# CHECK-NEXT:    Total number of mappings created: 0
# CHECK-NEXT:    Max number of mappings used:      0

# CHECK:      *  Register File #2 -- JIntegerPRF:
# CHECK-NEXT:    Number of physical registers:     64
# CHECK-NEXT:    Total number of mappings created: 800
# CHECK-NEXT:    Max number of mappings used:      12
# CHECK-NEXT:    Number of optimizable moves:      100
# CHECK-NEXT:    Number of moves eliminated:       100  (100.0%)
# CHECK-NEXT:    Number of zero moves:             100  (100.0%)
# CHECK-NEXT:    Max moves eliminated per cycle:   1

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 2.00   2.00    -      -      -      -      -      -      -      -      -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -      -      -      -     xorq	%rsi, %rsi
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -      -      -      -      -      -      -     addq	%rcx, %rcx
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -      -     addq	%rcx, %rcx
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -      -      -      -      -      -      -     addq	%rcx, %rcx
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -      -     addq	%rcx, %rcx
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -      -      -      -     movl	%esi, %ecx

# CHECK:      Timeline view:
# CHECK-NEXT:                     012
# CHECK-NEXT: Index     0123456789

# CHECK:      [0,0]     DR   .    . .   xorq	%rsi, %rsi
# CHECK-NEXT: [0,1]     DeER .    . .   addq	%rcx, %rcx
# CHECK-NEXT: [0,2]     .DeER.    . .   addq	%rcx, %rcx
# CHECK-NEXT: [0,3]     .D=eER    . .   addq	%rcx, %rcx
# CHECK-NEXT: [0,4]     . D=eER   . .   addq	%rcx, %rcx
# CHECK-NEXT: [0,5]     . D---R   . .   movl	%esi, %ecx
# CHECK-NEXT: [1,0]     .  D---R  . .   xorq	%rsi, %rsi
# CHECK-NEXT: [1,1]     .  DeE-R  . .   addq	%rcx, %rcx
# CHECK-NEXT: [1,2]     .   DeE-R . .   addq	%rcx, %rcx
# CHECK-NEXT: [1,3]     .   D=eER . .   addq	%rcx, %rcx
# CHECK-NEXT: [1,4]     .    D=eER. .   addq	%rcx, %rcx
# CHECK-NEXT: [1,5]     .    D---R. .   movl	%esi, %ecx
# CHECK-NEXT: [2,0]     .    .D---R .   xorq	%rsi, %rsi
# CHECK-NEXT: [2,1]     .    .DeE-R .   addq	%rcx, %rcx
# CHECK-NEXT: [2,2]     .    . DeE-R.   addq	%rcx, %rcx
# CHECK-NEXT: [2,3]     .    . D=eER.   addq	%rcx, %rcx
# CHECK-NEXT: [2,4]     .    .  D=eER   addq	%rcx, %rcx
# CHECK-NEXT: [2,5]     .    .  D---R   movl	%esi, %ecx

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     3     0.0    0.0    2.0       xorq	%rsi, %rsi
# CHECK-NEXT: 1.     3     1.0    1.0    0.7       addq	%rcx, %rcx
# CHECK-NEXT: 2.     3     1.0    0.0    0.7       addq	%rcx, %rcx
# CHECK-NEXT: 3.     3     2.0    0.0    0.0       addq	%rcx, %rcx
# CHECK-NEXT: 4.     3     2.0    0.0    0.0       addq	%rcx, %rcx
# CHECK-NEXT: 5.     3     0.0    0.0    3.0       movl	%esi, %ecx
# CHECK-NEXT:        3     1.0    0.2    1.1       <total>