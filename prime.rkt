#lang basic-vm

10 input n rem asks the user to input a number
20 if n < 2 then goto 80
30 let i = 2
40 if i * i > n then goto 70
50 if n mod i = 0 then goto 80
60 let i = i + 1
65 goto 40
70 print "prime"
75 end
80 print "not prime"
85 end




