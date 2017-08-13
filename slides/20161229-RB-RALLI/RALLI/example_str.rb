#coding: utf-8
require_relative 'rasm'
r=Rasm.new
r.load(
 'movi $str,""STRING!!""
  puts $str')
r.run