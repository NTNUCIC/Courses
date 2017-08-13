#coding: utf-8
require_relative 'rasm'
r=Rasm.new
r.load '
  movi $eax,2266
  jmp #DST
  movi $eax,"string"
  puts $eax
  #DST
  p $eax
'
r.run
