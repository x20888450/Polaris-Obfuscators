; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 < %s | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 < %s | FileCheck %s --check-prefix=LA64

;; TODO: Add optimization to ISD::ROTL

define i32 @rotl_32(i32 %x, i32 %y) nounwind {
; LA32-LABEL: rotl_32:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 32
; LA32-NEXT:    sub.w $a1, $a2, $a1
; LA32-NEXT:    rotr.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: rotl_32:
; LA64:       # %bb.0:
; LA64-NEXT:    sub.d $a2, $zero, $a1
; LA64-NEXT:    sll.w $a1, $a0, $a1
; LA64-NEXT:    srl.w $a0, $a0, $a2
; LA64-NEXT:    or $a0, $a1, $a0
; LA64-NEXT:    ret
  %z = sub i32 32, %y
  %b = shl i32 %x, %y
  %c = lshr i32 %x, %z
  %d = or i32 %b, %c
  ret i32 %d
}

define i32 @rotr_32(i32 %x, i32 %y) nounwind {
; LA32-LABEL: rotr_32:
; LA32:       # %bb.0:
; LA32-NEXT:    rotr.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: rotr_32:
; LA64:       # %bb.0:
; LA64-NEXT:    rotr.w $a0, $a0, $a1
; LA64-NEXT:    ret
  %z = sub i32 32, %y
  %b = lshr i32 %x, %y
  %c = shl i32 %x, %z
  %d = or i32 %b, %c
  ret i32 %d
}

define i64 @rotl_64(i64 %x, i64 %y) nounwind {
; LA32-LABEL: rotl_64:
; LA32:       # %bb.0:
; LA32-NEXT:    xori $a3, $a2, 31
; LA32-NEXT:    srli.w $a4, $a0, 1
; LA32-NEXT:    srl.w $a3, $a4, $a3
; LA32-NEXT:    sll.w $a4, $a1, $a2
; LA32-NEXT:    or $a3, $a4, $a3
; LA32-NEXT:    addi.w $a4, $a2, -32
; LA32-NEXT:    slti $a5, $a4, 0
; LA32-NEXT:    maskeqz $a3, $a3, $a5
; LA32-NEXT:    sll.w $a6, $a0, $a4
; LA32-NEXT:    masknez $a5, $a6, $a5
; LA32-NEXT:    or $a3, $a3, $a5
; LA32-NEXT:    ori $a5, $zero, 64
; LA32-NEXT:    sub.w $a5, $a5, $a2
; LA32-NEXT:    xori $a5, $a5, 31
; LA32-NEXT:    slli.w $a6, $a1, 1
; LA32-NEXT:    sll.w $a5, $a6, $a5
; LA32-NEXT:    sub.w $a6, $zero, $a2
; LA32-NEXT:    srl.w $a7, $a1, $a6
; LA32-NEXT:    ori $a1, $zero, 32
; LA32-NEXT:    sub.w $t0, $a1, $a2
; LA32-NEXT:    srai.w $a1, $t0, 31
; LA32-NEXT:    and $a1, $a1, $a7
; LA32-NEXT:    or $a1, $a3, $a1
; LA32-NEXT:    srl.w $a3, $a0, $a6
; LA32-NEXT:    or $a3, $a3, $a5
; LA32-NEXT:    slti $a5, $t0, 0
; LA32-NEXT:    masknez $a6, $a7, $a5
; LA32-NEXT:    maskeqz $a3, $a3, $a5
; LA32-NEXT:    or $a3, $a3, $a6
; LA32-NEXT:    sll.w $a0, $a0, $a2
; LA32-NEXT:    srai.w $a2, $a4, 31
; LA32-NEXT:    and $a0, $a2, $a0
; LA32-NEXT:    or $a0, $a0, $a3
; LA32-NEXT:    ret
;
; LA64-LABEL: rotl_64:
; LA64:       # %bb.0:
; LA64-NEXT:    ori $a2, $zero, 64
; LA64-NEXT:    sub.d $a1, $a2, $a1
; LA64-NEXT:    rotr.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %z = sub i64 64, %y
  %b = shl i64 %x, %y
  %c = lshr i64 %x, %z
  %d = or i64 %b, %c
  ret i64 %d
}

define i64 @rotr_64(i64 %x, i64 %y) nounwind {
; LA32-LABEL: rotr_64:
; LA32:       # %bb.0:
; LA32-NEXT:    xori $a3, $a2, 31
; LA32-NEXT:    slli.w $a4, $a1, 1
; LA32-NEXT:    sll.w $a3, $a4, $a3
; LA32-NEXT:    srl.w $a4, $a0, $a2
; LA32-NEXT:    or $a3, $a4, $a3
; LA32-NEXT:    addi.w $a4, $a2, -32
; LA32-NEXT:    slti $a5, $a4, 0
; LA32-NEXT:    maskeqz $a3, $a3, $a5
; LA32-NEXT:    srl.w $a6, $a1, $a4
; LA32-NEXT:    masknez $a5, $a6, $a5
; LA32-NEXT:    or $a3, $a3, $a5
; LA32-NEXT:    ori $a5, $zero, 64
; LA32-NEXT:    sub.w $a5, $a5, $a2
; LA32-NEXT:    xori $a5, $a5, 31
; LA32-NEXT:    srli.w $a6, $a0, 1
; LA32-NEXT:    srl.w $a5, $a6, $a5
; LA32-NEXT:    sub.w $a6, $zero, $a2
; LA32-NEXT:    sll.w $a7, $a0, $a6
; LA32-NEXT:    ori $a0, $zero, 32
; LA32-NEXT:    sub.w $t0, $a0, $a2
; LA32-NEXT:    srai.w $a0, $t0, 31
; LA32-NEXT:    and $a0, $a0, $a7
; LA32-NEXT:    or $a0, $a3, $a0
; LA32-NEXT:    sll.w $a3, $a1, $a6
; LA32-NEXT:    or $a3, $a3, $a5
; LA32-NEXT:    slti $a5, $t0, 0
; LA32-NEXT:    masknez $a6, $a7, $a5
; LA32-NEXT:    maskeqz $a3, $a3, $a5
; LA32-NEXT:    or $a3, $a3, $a6
; LA32-NEXT:    srl.w $a1, $a1, $a2
; LA32-NEXT:    srai.w $a2, $a4, 31
; LA32-NEXT:    and $a1, $a2, $a1
; LA32-NEXT:    or $a1, $a1, $a3
; LA32-NEXT:    ret
;
; LA64-LABEL: rotr_64:
; LA64:       # %bb.0:
; LA64-NEXT:    rotr.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %z = sub i64 64, %y
  %b = lshr i64 %x, %y
  %c = shl i64 %x, %z
  %d = or i64 %b, %c
  ret i64 %d
}

define i32 @rotl_32_mask(i32 %x, i32 %y) nounwind {
; LA32-LABEL: rotl_32_mask:
; LA32:       # %bb.0:
; LA32-NEXT:    sub.w $a1, $zero, $a1
; LA32-NEXT:    rotr.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: rotl_32_mask:
; LA64:       # %bb.0:
; LA64-NEXT:    sub.d $a2, $zero, $a1
; LA64-NEXT:    sll.w $a1, $a0, $a1
; LA64-NEXT:    srl.w $a0, $a0, $a2
; LA64-NEXT:    or $a0, $a1, $a0
; LA64-NEXT:    ret
  %z = sub i32 0, %y
  %and = and i32 %z, 31
  %b = shl i32 %x, %y
  %c = lshr i32 %x, %and
  %d = or i32 %b, %c
  ret i32 %d
}

define i32 @rotl_32_mask_and_63_and_31(i32 %x, i32 %y) nounwind {
; LA32-LABEL: rotl_32_mask_and_63_and_31:
; LA32:       # %bb.0:
; LA32-NEXT:    sub.w $a1, $zero, $a1
; LA32-NEXT:    rotr.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: rotl_32_mask_and_63_and_31:
; LA64:       # %bb.0:
; LA64-NEXT:    sub.d $a2, $zero, $a1
; LA64-NEXT:    sll.w $a1, $a0, $a1
; LA64-NEXT:    srl.w $a0, $a0, $a2
; LA64-NEXT:    or $a0, $a1, $a0
; LA64-NEXT:    ret
  %a = and i32 %y, 63
  %b = shl i32 %x, %a
  %c = sub i32 0, %y
  %d = and i32 %c, 31
  %e = lshr i32 %x, %d
  %f = or i32 %b, %e
  ret i32 %f
}

define i32 @rotl_32_mask_or_64_or_32(i32 %x, i32 %y) nounwind {
; LA32-LABEL: rotl_32_mask_or_64_or_32:
; LA32:       # %bb.0:
; LA32-NEXT:    sub.w $a1, $zero, $a1
; LA32-NEXT:    rotr.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: rotl_32_mask_or_64_or_32:
; LA64:       # %bb.0:
; LA64-NEXT:    sub.d $a2, $zero, $a1
; LA64-NEXT:    sll.w $a1, $a0, $a1
; LA64-NEXT:    srl.w $a0, $a0, $a2
; LA64-NEXT:    or $a0, $a1, $a0
; LA64-NEXT:    ret
  %a = or i32 %y, 64
  %b = shl i32 %x, %a
  %c = sub i32 0, %y
  %d = or i32 %c, 32
  %e = lshr i32 %x, %d
  %f = or i32 %b, %e
  ret i32 %f
}

define i32 @rotr_32_mask(i32 %x, i32 %y) nounwind {
; LA32-LABEL: rotr_32_mask:
; LA32:       # %bb.0:
; LA32-NEXT:    rotr.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: rotr_32_mask:
; LA64:       # %bb.0:
; LA64-NEXT:    rotr.w $a0, $a0, $a1
; LA64-NEXT:    ret
  %z = sub i32 0, %y
  %and = and i32 %z, 31
  %b = lshr i32 %x, %y
  %c = shl i32 %x, %and
  %d = or i32 %b, %c
  ret i32 %d
}

define i32 @rotr_32_mask_and_63_and_31(i32 %x, i32 %y) nounwind {
; LA32-LABEL: rotr_32_mask_and_63_and_31:
; LA32:       # %bb.0:
; LA32-NEXT:    rotr.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: rotr_32_mask_and_63_and_31:
; LA64:       # %bb.0:
; LA64-NEXT:    rotr.w $a0, $a0, $a1
; LA64-NEXT:    ret
  %a = and i32 %y, 63
  %b = lshr i32 %x, %a
  %c = sub i32 0, %y
  %d = and i32 %c, 31
  %e = shl i32 %x, %d
  %f = or i32 %b, %e
  ret i32 %f
}

define i32 @rotr_32_mask_or_64_or_32(i32 %x, i32 %y) nounwind {
; LA32-LABEL: rotr_32_mask_or_64_or_32:
; LA32:       # %bb.0:
; LA32-NEXT:    rotr.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: rotr_32_mask_or_64_or_32:
; LA64:       # %bb.0:
; LA64-NEXT:    rotr.w $a0, $a0, $a1
; LA64-NEXT:    ret
  %a = or i32 %y, 64
  %b = lshr i32 %x, %a
  %c = sub i32 0, %y
  %d = or i32 %c, 32
  %e = shl i32 %x, %d
  %f = or i32 %b, %e
  ret i32 %f
}

define i64 @rotl_64_mask(i64 %x, i64 %y) nounwind {
; LA32-LABEL: rotl_64_mask:
; LA32:       # %bb.0:
; LA32-NEXT:    xori $a3, $a2, 31
; LA32-NEXT:    srli.w $a4, $a0, 1
; LA32-NEXT:    srl.w $a3, $a4, $a3
; LA32-NEXT:    sll.w $a4, $a1, $a2
; LA32-NEXT:    or $a3, $a4, $a3
; LA32-NEXT:    sub.w $a4, $zero, $a2
; LA32-NEXT:    srl.w $a5, $a1, $a4
; LA32-NEXT:    andi $a6, $a4, 63
; LA32-NEXT:    addi.w $a7, $a6, -32
; LA32-NEXT:    srai.w $t0, $a7, 31
; LA32-NEXT:    and $a5, $t0, $a5
; LA32-NEXT:    addi.w $t0, $a2, -32
; LA32-NEXT:    slti $t1, $t0, 0
; LA32-NEXT:    maskeqz $a3, $a3, $t1
; LA32-NEXT:    sll.w $t2, $a0, $t0
; LA32-NEXT:    masknez $t1, $t2, $t1
; LA32-NEXT:    or $a3, $a3, $t1
; LA32-NEXT:    xori $a6, $a6, 31
; LA32-NEXT:    slli.w $t1, $a1, 1
; LA32-NEXT:    sll.w $a6, $t1, $a6
; LA32-NEXT:    or $a3, $a3, $a5
; LA32-NEXT:    srl.w $a4, $a0, $a4
; LA32-NEXT:    or $a4, $a4, $a6
; LA32-NEXT:    srl.w $a1, $a1, $a7
; LA32-NEXT:    slti $a5, $a7, 0
; LA32-NEXT:    masknez $a1, $a1, $a5
; LA32-NEXT:    maskeqz $a4, $a4, $a5
; LA32-NEXT:    or $a1, $a4, $a1
; LA32-NEXT:    sll.w $a0, $a0, $a2
; LA32-NEXT:    srai.w $a2, $t0, 31
; LA32-NEXT:    and $a0, $a2, $a0
; LA32-NEXT:    or $a0, $a0, $a1
; LA32-NEXT:    move $a1, $a3
; LA32-NEXT:    ret
;
; LA64-LABEL: rotl_64_mask:
; LA64:       # %bb.0:
; LA64-NEXT:    sub.d $a1, $zero, $a1
; LA64-NEXT:    rotr.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %z = sub i64 0, %y
  %and = and i64 %z, 63
  %b = shl i64 %x, %y
  %c = lshr i64 %x, %and
  %d = or i64 %b, %c
  ret i64 %d
}

define i64 @rotl_64_mask_and_127_and_63(i64 %x, i64 %y) nounwind {
; LA32-LABEL: rotl_64_mask_and_127_and_63:
; LA32:       # %bb.0:
; LA32-NEXT:    srli.w $a3, $a0, 1
; LA32-NEXT:    andi $a4, $a2, 127
; LA32-NEXT:    xori $a5, $a4, 31
; LA32-NEXT:    srl.w $a3, $a3, $a5
; LA32-NEXT:    sll.w $a5, $a1, $a2
; LA32-NEXT:    or $a3, $a5, $a3
; LA32-NEXT:    sub.w $a5, $zero, $a2
; LA32-NEXT:    srl.w $a6, $a1, $a5
; LA32-NEXT:    andi $a7, $a5, 63
; LA32-NEXT:    addi.w $t0, $a7, -32
; LA32-NEXT:    srai.w $t1, $t0, 31
; LA32-NEXT:    and $a6, $t1, $a6
; LA32-NEXT:    addi.w $a4, $a4, -32
; LA32-NEXT:    slti $t1, $a4, 0
; LA32-NEXT:    maskeqz $a3, $a3, $t1
; LA32-NEXT:    sll.w $t2, $a0, $a4
; LA32-NEXT:    masknez $t1, $t2, $t1
; LA32-NEXT:    or $a3, $a3, $t1
; LA32-NEXT:    xori $a7, $a7, 31
; LA32-NEXT:    slli.w $t1, $a1, 1
; LA32-NEXT:    sll.w $a7, $t1, $a7
; LA32-NEXT:    or $a3, $a3, $a6
; LA32-NEXT:    srl.w $a5, $a0, $a5
; LA32-NEXT:    or $a5, $a5, $a7
; LA32-NEXT:    srl.w $a1, $a1, $t0
; LA32-NEXT:    slti $a6, $t0, 0
; LA32-NEXT:    masknez $a1, $a1, $a6
; LA32-NEXT:    maskeqz $a5, $a5, $a6
; LA32-NEXT:    or $a1, $a5, $a1
; LA32-NEXT:    sll.w $a0, $a0, $a2
; LA32-NEXT:    srai.w $a2, $a4, 31
; LA32-NEXT:    and $a0, $a2, $a0
; LA32-NEXT:    or $a0, $a0, $a1
; LA32-NEXT:    move $a1, $a3
; LA32-NEXT:    ret
;
; LA64-LABEL: rotl_64_mask_and_127_and_63:
; LA64:       # %bb.0:
; LA64-NEXT:    sub.d $a1, $zero, $a1
; LA64-NEXT:    rotr.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %a = and i64 %y, 127
  %b = shl i64 %x, %a
  %c = sub i64 0, %y
  %d = and i64 %c, 63
  %e = lshr i64 %x, %d
  %f = or i64 %b, %e
  ret i64 %f
}

define i64 @rotl_64_mask_or_128_or_64(i64 %x, i64 %y) nounwind {
; LA32-LABEL: rotl_64_mask_or_128_or_64:
; LA32:       # %bb.0:
; LA32-NEXT:    sll.w $a3, $a0, $a2
; LA32-NEXT:    sub.w $a0, $zero, $a2
; LA32-NEXT:    srl.w $a0, $a1, $a0
; LA32-NEXT:    move $a1, $a3
; LA32-NEXT:    ret
;
; LA64-LABEL: rotl_64_mask_or_128_or_64:
; LA64:       # %bb.0:
; LA64-NEXT:    sub.d $a1, $zero, $a1
; LA64-NEXT:    rotr.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %a = or i64 %y, 128
  %b = shl i64 %x, %a
  %c = sub i64 0, %y
  %d = or i64 %c, 64
  %e = lshr i64 %x, %d
  %f = or i64 %b, %e
  ret i64 %f
}

define i64 @rotr_64_mask(i64 %x, i64 %y) nounwind {
; LA32-LABEL: rotr_64_mask:
; LA32:       # %bb.0:
; LA32-NEXT:    xori $a3, $a2, 31
; LA32-NEXT:    slli.w $a4, $a1, 1
; LA32-NEXT:    sll.w $a3, $a4, $a3
; LA32-NEXT:    srl.w $a4, $a0, $a2
; LA32-NEXT:    or $a3, $a4, $a3
; LA32-NEXT:    sub.w $a4, $zero, $a2
; LA32-NEXT:    sll.w $a5, $a0, $a4
; LA32-NEXT:    andi $a6, $a4, 63
; LA32-NEXT:    addi.w $a7, $a6, -32
; LA32-NEXT:    srai.w $t0, $a7, 31
; LA32-NEXT:    and $a5, $t0, $a5
; LA32-NEXT:    addi.w $t0, $a2, -32
; LA32-NEXT:    slti $t1, $t0, 0
; LA32-NEXT:    maskeqz $a3, $a3, $t1
; LA32-NEXT:    srl.w $t2, $a1, $t0
; LA32-NEXT:    masknez $t1, $t2, $t1
; LA32-NEXT:    or $a3, $a3, $t1
; LA32-NEXT:    xori $a6, $a6, 31
; LA32-NEXT:    srli.w $t1, $a0, 1
; LA32-NEXT:    srl.w $a6, $t1, $a6
; LA32-NEXT:    or $a3, $a3, $a5
; LA32-NEXT:    sll.w $a4, $a1, $a4
; LA32-NEXT:    or $a4, $a4, $a6
; LA32-NEXT:    sll.w $a0, $a0, $a7
; LA32-NEXT:    slti $a5, $a7, 0
; LA32-NEXT:    masknez $a0, $a0, $a5
; LA32-NEXT:    maskeqz $a4, $a4, $a5
; LA32-NEXT:    or $a0, $a4, $a0
; LA32-NEXT:    srl.w $a1, $a1, $a2
; LA32-NEXT:    srai.w $a2, $t0, 31
; LA32-NEXT:    and $a1, $a2, $a1
; LA32-NEXT:    or $a1, $a1, $a0
; LA32-NEXT:    move $a0, $a3
; LA32-NEXT:    ret
;
; LA64-LABEL: rotr_64_mask:
; LA64:       # %bb.0:
; LA64-NEXT:    rotr.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %z = sub i64 0, %y
  %and = and i64 %z, 63
  %b = lshr i64 %x, %y
  %c = shl i64 %x, %and
  %d = or i64 %b, %c
  ret i64 %d
}

define i64 @rotr_64_mask_and_127_and_63(i64 %x, i64 %y) nounwind {
; LA32-LABEL: rotr_64_mask_and_127_and_63:
; LA32:       # %bb.0:
; LA32-NEXT:    slli.w $a3, $a1, 1
; LA32-NEXT:    andi $a4, $a2, 127
; LA32-NEXT:    xori $a5, $a4, 31
; LA32-NEXT:    sll.w $a3, $a3, $a5
; LA32-NEXT:    srl.w $a5, $a0, $a2
; LA32-NEXT:    or $a3, $a5, $a3
; LA32-NEXT:    sub.w $a5, $zero, $a2
; LA32-NEXT:    sll.w $a6, $a0, $a5
; LA32-NEXT:    andi $a7, $a5, 63
; LA32-NEXT:    addi.w $t0, $a7, -32
; LA32-NEXT:    srai.w $t1, $t0, 31
; LA32-NEXT:    and $a6, $t1, $a6
; LA32-NEXT:    addi.w $a4, $a4, -32
; LA32-NEXT:    slti $t1, $a4, 0
; LA32-NEXT:    maskeqz $a3, $a3, $t1
; LA32-NEXT:    srl.w $t2, $a1, $a4
; LA32-NEXT:    masknez $t1, $t2, $t1
; LA32-NEXT:    or $a3, $a3, $t1
; LA32-NEXT:    xori $a7, $a7, 31
; LA32-NEXT:    srli.w $t1, $a0, 1
; LA32-NEXT:    srl.w $a7, $t1, $a7
; LA32-NEXT:    or $a3, $a3, $a6
; LA32-NEXT:    sll.w $a5, $a1, $a5
; LA32-NEXT:    or $a5, $a5, $a7
; LA32-NEXT:    sll.w $a0, $a0, $t0
; LA32-NEXT:    slti $a6, $t0, 0
; LA32-NEXT:    masknez $a0, $a0, $a6
; LA32-NEXT:    maskeqz $a5, $a5, $a6
; LA32-NEXT:    or $a0, $a5, $a0
; LA32-NEXT:    srl.w $a1, $a1, $a2
; LA32-NEXT:    srai.w $a2, $a4, 31
; LA32-NEXT:    and $a1, $a2, $a1
; LA32-NEXT:    or $a1, $a1, $a0
; LA32-NEXT:    move $a0, $a3
; LA32-NEXT:    ret
;
; LA64-LABEL: rotr_64_mask_and_127_and_63:
; LA64:       # %bb.0:
; LA64-NEXT:    rotr.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %a = and i64 %y, 127
  %b = lshr i64 %x, %a
  %c = sub i64 0, %y
  %d = and i64 %c, 63
  %e = shl i64 %x, %d
  %f = or i64 %b, %e
  ret i64 %f
}

define i64 @rotr_64_mask_or_128_or_64(i64 %x, i64 %y) nounwind {
; LA32-LABEL: rotr_64_mask_or_128_or_64:
; LA32:       # %bb.0:
; LA32-NEXT:    srl.w $a3, $a1, $a2
; LA32-NEXT:    sub.w $a1, $zero, $a2
; LA32-NEXT:    sll.w $a1, $a0, $a1
; LA32-NEXT:    move $a0, $a3
; LA32-NEXT:    ret
;
; LA64-LABEL: rotr_64_mask_or_128_or_64:
; LA64:       # %bb.0:
; LA64-NEXT:    rotr.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %a = or i64 %y, 128
  %b = lshr i64 %x, %a
  %c = sub i64 0, %y
  %d = or i64 %c, 64
  %e = shl i64 %x, %d
  %f = or i64 %b, %e
  ret i64 %f
}

define i32 @rotri_i32(i32 %a) nounwind {
; LA32-LABEL: rotri_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    rotri.w $a0, $a0, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: rotri_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    rotri.w $a0, $a0, 16
; LA64-NEXT:    ret
  %shl = shl i32 %a, 16
  %shr = lshr i32 %a, 16
  %or = or i32 %shl, %shr
  ret i32 %or
}

define i64 @rotri_i64(i64 %a) nounwind {
; LA32-LABEL: rotri_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    move $a2, $a0
; LA32-NEXT:    move $a0, $a1
; LA32-NEXT:    move $a1, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: rotri_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    rotri.d $a0, $a0, 32
; LA64-NEXT:    ret
  %shl = shl i64 %a, 32
  %shr = lshr i64 %a, 32
  %or = or i64 %shl, %shr
  ret i64 %or
}

declare i32 @llvm.fshl.i32(i32, i32, i32)
declare i64 @llvm.fshl.i64(i64, i64, i64)
declare i32 @llvm.fshr.i32(i32, i32, i32)
declare i64 @llvm.fshr.i64(i64, i64, i64)

define signext i32 @rotl_i32_fshl(i32 signext %a) nounwind {
; LA32-LABEL: rotl_i32_fshl:
; LA32:       # %bb.0:
; LA32-NEXT:    rotri.w $a0, $a0, 20
; LA32-NEXT:    ret
;
; LA64-LABEL: rotl_i32_fshl:
; LA64:       # %bb.0:
; LA64-NEXT:    rotri.w $a0, $a0, 20
; LA64-NEXT:    ret
  %or = tail call i32 @llvm.fshl.i32(i32 %a, i32 %a, i32 12)
  ret i32 %or
}

define i64 @rotl_i64_fshl(i64 %a) nounwind {
; LA32-LABEL: rotl_i64_fshl:
; LA32:       # %bb.0:
; LA32-NEXT:    srli.w $a2, $a1, 20
; LA32-NEXT:    slli.w $a3, $a0, 12
; LA32-NEXT:    or $a2, $a3, $a2
; LA32-NEXT:    srli.w $a0, $a0, 20
; LA32-NEXT:    slli.w $a1, $a1, 12
; LA32-NEXT:    or $a1, $a1, $a0
; LA32-NEXT:    move $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: rotl_i64_fshl:
; LA64:       # %bb.0:
; LA64-NEXT:    rotri.d $a0, $a0, 52
; LA64-NEXT:    ret
  %or = tail call i64 @llvm.fshl.i64(i64 %a, i64 %a, i64 12)
  ret i64 %or
}

define signext i32 @rotr_i32_fshr(i32 signext %a) nounwind {
; LA32-LABEL: rotr_i32_fshr:
; LA32:       # %bb.0:
; LA32-NEXT:    rotri.w $a0, $a0, 12
; LA32-NEXT:    ret
;
; LA64-LABEL: rotr_i32_fshr:
; LA64:       # %bb.0:
; LA64-NEXT:    slli.d $a1, $a0, 20
; LA64-NEXT:    bstrpick.d $a0, $a0, 31, 12
; LA64-NEXT:    or $a0, $a0, $a1
; LA64-NEXT:    addi.w $a0, $a0, 0
; LA64-NEXT:    ret
  %or = tail call i32 @llvm.fshr.i32(i32 %a, i32 %a, i32 12)
  ret i32 %or
}

define i64 @rotr_i64_fshr(i64 %a) nounwind {
; LA32-LABEL: rotr_i64_fshr:
; LA32:       # %bb.0:
; LA32-NEXT:    srli.w $a2, $a0, 12
; LA32-NEXT:    slli.w $a3, $a1, 20
; LA32-NEXT:    or $a2, $a3, $a2
; LA32-NEXT:    srli.w $a1, $a1, 12
; LA32-NEXT:    slli.w $a0, $a0, 20
; LA32-NEXT:    or $a1, $a0, $a1
; LA32-NEXT:    move $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: rotr_i64_fshr:
; LA64:       # %bb.0:
; LA64-NEXT:    rotri.d $a0, $a0, 12
; LA64-NEXT:    ret
  %or = tail call i64 @llvm.fshr.i64(i64 %a, i64 %a, i64 12)
  ret i64 %or
}