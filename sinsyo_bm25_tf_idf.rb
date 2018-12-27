#!/usr/lib/ruby
# -*- coding: utf-8 -*-
require 'natto'
require 'bigdecimal'
require 'bigdecimal/util'

#IDFを読み込む
text_file = "sinsyo_idf.txt"
file = open(text_file)

text = Array.new
file.each_line {|line|
  line.chomp!
  text.push(line)
}
#p text

#1要素ずつ配列に入れる
idf_a = Array.new
  text.each {|a|
  idf_a.push(a.split(",")) #バーで区切ったものが二重配列の最も中身
}
#p idf_a #[単語,IDF]

idf_b = Array.new #キーワードシステム用のbm25
idf_a.each{|k,idf|
idf_b_v = (idf.to_d * 1.5277777777777777).to_d.to_f #定数倍
idf_b.push([k,idf_b_v])
}
#p idf_b #[単語,IDF]


idf_b.each{|b|
  idf =  b[1].to_f
  score = idf.to_d.to_f #to_d to_iで浮動小数点の処理
  print b[0],",",b[0],",",score,"\n"
}
