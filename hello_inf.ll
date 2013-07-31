; Declare the string constant as a global constant.
@.str = private unnamed_addr constant [16 x i8] c"hello world %d\0A\00"

; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)

declare i32 @sleep(i32)

; Definition of main function
define i32 @main() {
LoopHeader:
  %str_addr = getelementptr [16 x i8]* @.str, i32 0, i32 0
  br label %Loop
  
Loop:       ; Infinite loop that counts from 0 on up...
  %indvar = phi i2 [ 0, %LoopHeader ], [ %nextindvar, %Loop ]
  %nextindvar = add nuw i2 %indvar, 1
  
  ; Call printf function to write out the string to stdout.
  call i32 (i8*, ...)* @printf(i8* %str_addr, i2 %nextindvar)
  call i32 (i32)* @sleep(i32 1)
  
;  %at_ten = icmp uge i2 %nextindvar, 3
;  br i1 %at_ten, label %End, label %Loop
  br label %Loop
End:
  ret i32 0
}
