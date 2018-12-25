#!/usr/lib/ruby
# -*- coding: utf-8 -*-
require 'bigdecimal'
require 'bigdecimal/util'
require 'natto'
#########################################################################
#一致した単語リストを読み込む
text_file = "keywords.txt"
#text_file = "gakumon_bm25_mini.txt"
file = open(text_file)

text = Array.new
file.each_line {|line|
  line.chomp!
  text.push(line)
}
#p text

#1要素ずつ配列に入れる
keywords_a = Array.new
  text.each {|a|
  keywords_a.push(a) #バーで区切ったものが二重配列の最も中身
}
#p keywords_a


########################################################################
#新書本
text_file = "sinsyo_bm25.txt"
#text_file = "sinsyo_bm25_mini.txt"
file = open(text_file)

text = Array.new
file.each_line {|line|
  line.chomp!
  text.push(line)
}
#p text

#1要素ずつ配列に入れる
sinsyo_bm25_a = Array.new
  text.each {|a|
  sinsyo_bm25_a.push(a.split(",")) #バーで区切ったものが二重配列の最も中身
}
p sinsyo_bm25_a

#一致するものだけをbm25付の形式で出力する
sinsyo_bm25_a.each{|a|
  keywords_a.each{|a2|
if a[0] == a2 #キーワードが一致
    print a[0],",",a[1],",",a[2],"\n"
end
  }
}
