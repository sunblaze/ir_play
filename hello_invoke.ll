; Declare the string constant as a global constant.
@.str = private unnamed_addr constant [16 x i8] c"hello world %d\0A\00"

; External declaration of the printf function
declare i32 @printf(i8* noalias nocapture, ...)

declare i32 @sleep(i32)

define void @bail_if_over_ten(i32 %nextindvar) {
  %at_ten = icmp uge i32 %nextindvar, 10
  br i1 %at_ten, label %Throw, label %Continue
Throw:
  
  
Continue:
  ret
}

; Definition of main function
define i32 @main() {
LoopHeader:
  %str_addr = getelementptr [16 x i8]* @.str, i32 0, i32 0
  br label %Loop
  
Loop:       ; Infinite loop that counts from 0 on up...
  %indvar = phi i32 [ 0, %LoopHeader ], [ %nextindvar, %Loop ]
  %nextindvar = add i32 %indvar, 1
  
  ; Call printf function to write out the string to stdout.
  call i32 (i8*, ...)* @printf(i8* %str_addr, i32 %nextindvar)
  call i32 (i32)* @sleep(i32 1)
  
  invoke void (i32) @bail_if_over_ten(%nextindvar)
End:
  ret i32 0
}