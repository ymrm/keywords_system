#!/usr/lib/ruby
# -*- coding: utf-8 -*-
require 'bigdecimal'
require 'bigdecimal/util'
require 'natto'
#########################################################################
#学問
text_file = "gakumon_bm25.txt"
#text_file = "gakumon_bm25_mini.txt"
file = open(text_file)

text = Array.new
file.each_line {|line|
  line.chomp!
  text.push(line)
}
#p text

#1要素ずつ配列に入れる
gakumon_bm25_a = Array.new
  text.each {|a|
  gakumon_bm25_a.push(a.split(",")) #バーで区切ったものが二重配列の最も中身
}
#p gakumon_bm25_a

gakumon_bm25_h = Hash.new{|hash, key| hash[key] = []}
  gakumon_bm25_a.each{|a|
    gakumon_bm25_h[a[0]].push([a[1],a[2]])
  }
#p gakumon_bm25_h #学問をキーとして、値として、単語とその重みのペアの>配列をもつハッシュ


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
#p sinsyo_bm25


sinsyo_bm25_h = Hash.new{|hash, key| hash[key] = []}
sinsyo_bm25_a.each{|a|
    sinsyo_bm25_h[a[0]].push([a[1],a[2]])
}
#p sinsyo_bm25_h #タイトルをキーとして、値として、単語とその重みのペアの配列をもつハッシュ


#一致する新書本対学問分野の単語リストを作る
#
match_keywords = Hash.new{|hash, key| hash[key] = []}
sinsyo_bm25_h.each{|ak,av|
  gakumon_bm25_h.each{|bk,bv|
    av.each{|c|
      bv.each{|d|
        if c[0] == d[0]
          # print "新書本",ak,"\n"
          # print "学問分野",bk,"\n"
          # p c[0]
          # p d[0]
           match_keywords[ak].push(c[0]) #一致する単語だけを新書本ごとに収集
          # print "単語が一致\n"
        end
        }
    }
  }
}
match_keywords.each{|k,v|
  v.uniq!
}
#p match_keywords
i = 0
match_keywords.each{|k,v|
#    print i,"|","\"",k,"\"" ,"|\""
  v.each{|vv|
#    print vv," "
    print vv,"\n"
  }
#    print "\"\n"
    i += 1
}
p i
