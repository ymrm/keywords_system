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
text_file = "sinsyo_bm25_4021.txt" #キーワードシステム用 #学問側と一致する単語4021単語のみのbm25
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
    print i,"|","\"",k,"\""#,"|\""
#  v.each{|vv|
#    print vv," "
#  }
    print "\n"
    i += 1
}

=begin

########################################################################
#コサイン類似度
require 'complex'
#コサイン類似度の分母
c_sum = Hash.new #新書本側の分母の二乗
sinsyo_bm25_h.each{|ak,av|
  c_sum[ak] = 0 #初期化(最初はゼロ)
  av.each{|c| #新書本ごとに
    c_sum[ak] += c[1].to_f ** 2 #二乗した値を加える
  }
}
#p c_sum #新書

d_sum = Hash.new #学問側の分母の二乗
gakumon_bm25_h.each{|bk,bv|
  d_sum[bk] = 0
  bv.each{|d| #学問ごとに
    d_sum[bk] += d[1].to_d ** 2
  }
}
#p d_sum #学問

#コサイン類似度の分母
cos_child_a = Array.new #コサイン類似度の分子を入れる配列 #新書本の数*学問の数ある
sinsyo_bm25_h.each{|ak,av| #新書本ループ
  gakumon_bm25_h.each{|bk,bv| #学問をループ
  cos_child = 0 #配列に入れるための類似度を一時的に計算するための変数
  av.each{|c| #新書本の単語と重みループ
    bv.each{|d| #学問の単語と重みをループ
      if d[0] == c[0] #単語が一致したら
        cos_child += d[1].to_d*c[1].to_d #同一の単語の重みを掛け合わせたものを足していく 
      end
      }
    }
    cos_child_a.push([ak,bk,cos_child]) #新書本、学問名、類似度の分子
  }
}
#p cos_child_a

#分子と分母を組み合わせる
cos_a = Array.new
cos_child_a.each{|child| #分子
  c_sum.each{|ck,cv| #分母(新書本)
    d_sum.each{|dk,dv| #分母(学問)
     if child[0] == ck && child[1] == dk #新書本と学問が両方とも一致したとき
       cos = (child[2]/(Math.sqrt(cv)*Math.sqrt(dv))).to_f #計算
       cos_a.push([ck,dk,cos]) #格納
     end
     }
  }
}

#表示
cos_a.each{|a|
print a[0],",",a[1],",",a[2],"\n"
}
=end
