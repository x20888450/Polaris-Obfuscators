; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple x86_64-unknown-linux-gnu < %s | FileCheck %s

define void @main() {
; CHECK-LABEL: main:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subq $424, %rsp # imm = 0x1A8
; CHECK-NEXT:    .cfi_def_cfa_offset 432
; CHECK-NEXT:    leaq {{[0-9]+}}(%rsp), %rdi
; CHECK-NEXT:    movl $400, %edx # imm = 0x190
; CHECK-NEXT:    xorl %esi, %esi
; CHECK-NEXT:    callq memset@PLT
; CHECK-NEXT:    movl {{[0-9]+}}(%rsp), %eax
; CHECK-NEXT:    movl (%rax), %ecx
; CHECK-NEXT:    addl 0, %eax
; CHECK-NEXT:    addl %ecx, %ecx
; CHECK-NEXT:    addl %eax, %ecx
; CHECK-NEXT:    addl {{[0-9]+}}(%rsp), %ecx
; CHECK-NEXT:    movl %ecx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movl {{[0-9]+}}(%rsp), %eax
; CHECK-NEXT:    movl %eax, %ecx
; CHECK-NEXT:    imull %eax, %ecx
; CHECK-NEXT:    subl %ecx, %eax
; CHECK-NEXT:    movl %eax, (%rax)
entry:
  %k = alloca i32, align 4
  %m = alloca i32, align 4
  %a = alloca [100 x i32], align 16
  call void @llvm.memset.p0.i64(ptr nonnull align 16 %a, i8 0, i64 400, i1 false)
  %arrayidx = getelementptr inbounds [100 x i32], ptr %a, i64 0, i64 34
  %add = load i32, ptr %k
  %0 = load i32, ptr null
  %1 = load i32, ptr undef
  %2 = load i32, ptr undef
  %3 = load i32, ptr %arrayidx
  %4 = load i32, ptr undef
  %5 = load i32, ptr undef
  %6 = load i32, ptr undef
  %7 = load i32, ptr undef
  %8 = load i32, ptr undef
  %9 = load i32, ptr undef
  %10 = load i32, ptr undef
  %11 = load i32, ptr undef
  %12 = load i32, ptr undef
  %13 = load i32, ptr undef
  %14 = load i32, ptr undef
  %15 = load i32, ptr undef
  %add.1 = add i32 %add, %0
  %add.2 = add i32 %add.1, %1
  %add.3 = add i32 %add.2, %2
  %add.4 = add i32 %add.3, %3
  store i32 %add.4, ptr %k
  %16 = load i32, ptr %m
  %mul = mul i32 %16, %16
  %sub = sub i32 %16, %mul
  store i32 %sub, ptr undef
  unreachable
}

declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1) #0

attributes #0 = { argmemonly nounwind }