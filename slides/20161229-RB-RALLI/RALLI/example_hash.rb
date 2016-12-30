#coding: utf-8
require_relative 'rasm'
r=Rasm.new
r.load '
  movc $eax,:Hash
  call $ecx,$eax,:new
  
  movr $eax,$ecx
  movc $ebx,:Time
  call $ebx,$ebx,:now
  save $eax,:TIME_NOW,$ebx
  movi $ebx,0
  
  movi $edx,"current_time: "
  print $edx
  call $ebx,$eax,:[],:TIME_NOW
  puts $ebx
'
r.run