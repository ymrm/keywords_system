#!/usr/lib/ruby
# -*- coding: utf-8 -*-
require 'natto'
require 'bigdecimal'
require 'bigdecimal/util'

#########################################################################
=begin

#TF
text_file = "sinsyo_tf.txt"
file = open(text_file)

text = Array.new
file.each_line {|line|
  line.chomp!
  text.push(line)
}
#p text

#1要素ずつ配列に入れる
tf_a = Array.new
  text.each {|a|
  tf_a.push(a.split(",")) #バーで区切ったものが二重配列の最も中身
}
#p tf_a #[学問,単語,tf]
=end
#
#######################################################################
#IDF
#1は底が2で+1してあるIDF
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
p idf_a #[単語,IDF]

idf_b = Array.new #キーワードシステム用のbm25
idf_a.each{|k,idf|
idf_b_v = (idf.to_d * 1.8333333333333333).to_d.to_f
idf_b.push([k,idf_b_v])
}
p idf_b #[単語,IDF]


########################################################################
=begin
#DL
text_file = "sinsyo_dl.txt"
file = open(text_file)

text = Array.new
file.each_line {|line|
  line.chomp!
  text.push(line)
}
#p text

#1要素ずつ配列に入れる
dl_a = Array.new
  text.each {|a|
  dl_a.push(a.split(",")) #バーで区切ったものが二重配列の最も中身
}
#p dl_a #[単語,DL]
dl_sum = 0
dl_a.each{|a|
  dl_sum += a[1].to_i
}
#p dl_sum
#p dl_a.size
avgdl = dl_sum.to_f/dl_a.size
=end
########################################################################
#出力
#tf_a.each{|a|
#  dl_a.each{|c|
#  if a[0] == c[0]
    idf_b.each{|b|
#      if a[1] == b[0]
#        dl = c[1].to_f
#        tf = a[2].to_f
        idf =  b[1].to_f
#        tfidf = tf * idf
#        k = 1.2
#        b = 0.75
#         score = (idf*((tf*(k+1)).to_d.to_f)/(tf+k*(1-b+(b*dl/avgdl))).to_d.to_f).to_d.to_f #to_d tio_iで浮動小数点の処理
         score = idf.to_d.to_f #to_d tio_iで浮動小数点の処理
#p ((tf*(k+1))).to_d.to_f
#p (tf+k*(1-b+(b*dl/avgdl))).to_d.to_f
        print b[0],",",b[0],",",score,"\n"
    #  end
    }
 # end
 # }
#}
