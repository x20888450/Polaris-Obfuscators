; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=2 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i64 @fn2() {
;
; TUNIT: Function Attrs: nofree norecurse nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@fn2
; TUNIT-SAME: () #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    ret i64 undef
;
; CGSCC: Function Attrs: nofree nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@fn2
; CGSCC-SAME: () #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[CONV:%.*]] = sext i32 undef to i64
; CGSCC-NEXT:    [[DIV:%.*]] = sdiv i64 8, [[CONV]]
; CGSCC-NEXT:    [[CALL2:%.*]] = call i64 @fn1(i64 [[DIV]]) #[[ATTR2:[0-9]+]]
; CGSCC-NEXT:    ret i64 [[CALL2]]
;
entry:
  %conv = sext i32 undef to i64
  %div = sdiv i64 8, %conv
  %call2 = call i64 @fn1(i64 %div)
  ret i64 %call2
}

define i64 @fn2b(i32 %arg) {
;
; TUNIT: Function Attrs: nofree norecurse nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@fn2b
; TUNIT-SAME: (i32 [[ARG:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[CONV:%.*]] = sext i32 [[ARG]] to i64
; TUNIT-NEXT:    [[DIV:%.*]] = sdiv i64 8, [[CONV]]
; TUNIT-NEXT:    ret i64 [[DIV]]
;
; CGSCC: Function Attrs: nofree nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@fn2b
; CGSCC-SAME: (i32 [[ARG:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[CONV:%.*]] = sext i32 [[ARG]] to i64
; CGSCC-NEXT:    [[DIV:%.*]] = sdiv i64 8, [[CONV]]
; CGSCC-NEXT:    [[CALL2:%.*]] = call i64 @fn1(i64 [[DIV]]) #[[ATTR2]]
; CGSCC-NEXT:    ret i64 [[CALL2]]
;
entry:
  %conv = sext i32 %arg to i64
  %div = sdiv i64 8, %conv
  %call2 = call i64 @fn1(i64 %div)
  ret i64 %call2
}

define i64 @fn2c() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@fn2c
; TUNIT-SAME: () #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    ret i64 42
;
; CGSCC: Function Attrs: nofree nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@fn2c
; CGSCC-SAME: () #[[ATTR0]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[CONV:%.*]] = sext i32 undef to i64
; CGSCC-NEXT:    [[ADD:%.*]] = add i64 42, [[CONV]]
; CGSCC-NEXT:    [[CALL2:%.*]] = call i64 @fn1(i64 [[ADD]]) #[[ATTR2]]
; CGSCC-NEXT:    ret i64 [[CALL2]]
;
entry:
  %conv = sext i32 undef to i64
  %add = add i64 42, %conv
  %call2 = call i64 @fn1(i64 %add)
  ret i64 %call2
}

define internal i64 @fn1(i64 %p1) {
; CGSCC: Function Attrs: nofree norecurse nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@fn1
; CGSCC-SAME: (i64 returned [[P1:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    ret i64 [[P1]]
;
entry:
  %tobool = icmp ne i64 %p1, 0
  %cond = select i1 %tobool, i64 %p1, i64 %p1
  ret i64 %cond
}
;.
; TUNIT: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind willreturn memory(none) }
;.
; CGSCC: attributes #[[ATTR0]] = { nofree nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR1]] = { nofree norecurse nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR2]] = { willreturn }
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}