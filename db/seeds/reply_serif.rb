# coding: utf-8

ActiveRecord::Base.connection.execute("TRUNCATE reply_serifs")
ReplySerif.create
([
   {:word => "は？（威圧）" },
   {:word => "この三十路が！" },
   {:word => "もう松来おっさんって呼ぼう"},
   {:word => "松来さん、ただの婆ちゃんじゃないですか"},
   {:word => "馬鹿にしてんな？おまえっ！"},
   {:word => "いいだろーいいだろー貸してあげない"},
   {:word => "ばかもの！"},
   {:word => "おっちえなーい"}
])
