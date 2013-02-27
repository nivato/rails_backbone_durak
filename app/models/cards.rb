class Cards
  
  @@cards = {
    "1"   => {"rank" => "6",  "rank_number" => 6,   "suit" => "s", "sign" => "6\u2660"},
    "2"   => {"rank" => "7",  "rank_number" => 7,   "suit" => "s", "sign" => "7\u2660"},
    "3"   => {"rank" => "8",  "rank_number" => 8,   "suit" => "s", "sign" => "8\u2660"},
    "4"   => {"rank" => "9",  "rank_number" => 9,   "suit" => "s", "sign" => "9\u2660"},
    "5"   => {"rank" => "10", "rank_number" => 10,  "suit" => "s", "sign" => "10\u2660"},
    "6"   => {"rank" => "J",  "rank_number" => 11,  "suit" => "s", "sign" => "J\u2660"},
    "7"   => {"rank" => "Q",  "rank_number" => 12,  "suit" => "s", "sign" => "Q\u2660"},
    "8"   => {"rank" => "K",  "rank_number" => 13,  "suit" => "s", "sign" => "K\u2660"},
    "9"   => {"rank" => "A",  "rank_number" => 14,  "suit" => "s", "sign" => "A\u2660"},
    
    "10"  => {"rank" => "6",  "rank_number" => 6,   "suit" => "h", "sign" => "6\u2665"},
    "11"  => {"rank" => "7",  "rank_number" => 7,   "suit" => "h", "sign" => "7\u2665"},
    "12"  => {"rank" => "8",  "rank_number" => 8,   "suit" => "h", "sign" => "8\u2665"},
    "13"  => {"rank" => "9",  "rank_number" => 9,   "suit" => "h", "sign" => "9\u2665"},
    "14"  => {"rank" => "10", "rank_number" => 10,  "suit" => "h", "sign" => "10\u2665"},
    "15"  => {"rank" => "J",  "rank_number" => 11,  "suit" => "h", "sign" => "J\u2665"},
    "16"  => {"rank" => "Q",  "rank_number" => 12,  "suit" => "h", "sign" => "Q\u2665"},
    "17"  => {"rank" => "K",  "rank_number" => 13,  "suit" => "h", "sign" => "K\u2665"},
    "18"  => {"rank" => "A",  "rank_number" => 14,  "suit" => "h", "sign" => "A\u2665"},
    
    "19"  => {"rank" => "6",  "rank_number" => 6,   "suit" => "d", "sign" => "6\u2666"},
    "20"  => {"rank" => "7",  "rank_number" => 7,   "suit" => "d", "sign" => "7\u2666"},
    "21"  => {"rank" => "8",  "rank_number" => 8,   "suit" => "d", "sign" => "8\u2666"},
    "22"  => {"rank" => "9",  "rank_number" => 9,   "suit" => "d", "sign" => "9\u2666"},
    "23"  => {"rank" => "10", "rank_number" => 10,  "suit" => "d", "sign" => "10\u2666"},
    "24"  => {"rank" => "J",  "rank_number" => 11,  "suit" => "d", "sign" => "J\u2666"},
    "25"  => {"rank" => "Q",  "rank_number" => 12,  "suit" => "d", "sign" => "Q\u2666"},
    "26"  => {"rank" => "K",  "rank_number" => 13,  "suit" => "d", "sign" => "K\u2666"},
    "27"  => {"rank" => "A",  "rank_number" => 14,  "suit" => "d", "sign" => "A\u2666"},
    
    "28"  => {"rank" => "6",  "rank_number" => 6,   "suit" => "c", "sign" => "6\u2663"},
    "29"  => {"rank" => "7",  "rank_number" => 7,   "suit" => "c", "sign" => "7\u2663"},
    "30"  => {"rank" => "8",  "rank_number" => 8,   "suit" => "c", "sign" => "8\u2663"},
    "31"  => {"rank" => "9",  "rank_number" => 9,   "suit" => "c", "sign" => "9\u2663"},
    "32"  => {"rank" => "10", "rank_number" => 10,  "suit" => "c", "sign" => "10\u2663"},
    "33"  => {"rank" => "J",  "rank_number" => 11,  "suit" => "c", "sign" => "J\u2663"},
    "34"  => {"rank" => "Q",  "rank_number" => 12,  "suit" => "c", "sign" => "Q\u2663"},
    "35"  => {"rank" => "K",  "rank_number" => 13,  "suit" => "c", "sign" => "K\u2663"},
    "36"  => {"rank" => "A",  "rank_number" => 14,  "suit" => "c", "sign" => "A\u2663"}
  }
  
  
  def self.rank(id)
    return @@cards[id.to_s]["rank"]
  end
  
  def self.rank_number(id)
    return @@cards[id.to_s]["rank_number"]
  end
  
  def self.suit(id)
    return @@cards[id.to_s]["suit"]
  end
  
  def self.sign(id)
    return @@cards[id.to_s]["sign"]
  end
  
end