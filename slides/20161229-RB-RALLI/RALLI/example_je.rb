#coding: utf-8
require_relative 'rasm'
r=Rasm.new
r.load(
 'movi $eax,1
  call $eax,$eax,:+,3
  movi $ebx,4
  movi $ecx,666
  je $eax,$ebx,#GO_THERE
  puts $ecx
  puts $ecx
  puts $ecx
  #GO_THERE
  puts $eax')
r.run