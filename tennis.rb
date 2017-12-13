def points(input)
  score_a = 0
  score_b = 0
  games_a = 0
  games_b = 0

  input.each_char do |c|
    if c == "a"
      score_a += 1
    elsif c == "b"
      score_b += 1
    end

    if (score_a > 3 || score_b > 3)
      if (score_a - score_b).abs > 1
        if score_a > score_b
          games_a += 1
        end

        if score_b > score_a
          games_b += 1
        end

        score_a = 0
        score_b = 0
      end
    end
  end

  {
    a: {score: scoring(score_a, score_b), games: games_a},
    b: {score: scoring(score_b, score_a), games: games_b}
  }
end

def scoring(count, other_count)
  if count == 0
    "love"
  elsif count == 1
    "15"
  elsif count == 2
    "30"
  else
    if count == 3
      if other_count <= 3
        "40"
      else
        ""
      end
    else
      if other_count < count
        "adv"
      elsif other_count == count
        "40"
      else
        ""
      end
    end
  end
end

puts points("") == {a: {score: "love", games:0}, b: {score:"love", games:0}}
puts points("")
puts points("a") == {a: {score: "15", games:0}, b: {score:"love", games:0}}
puts points("a") 
puts points("bbb") == {a: {score: "love", games:0}, b: {score:"40", games:0}}
puts points("bbb")
puts points("abab") == {a: {score: "30", games:0}, b: {score:"30", games:0}}
puts points("abab")
puts points("bbbb") == {a: {score: "love", games:0}, b: {score:"love", games:1}}
puts points("bbbb")
puts points("abbbbbbbbbbbb") == {a: {score: "love", games:0}, b: {score:"love", games:3}}
puts points("abbbbbbbbbbbb")
puts points("bbbbbbbbbbbba") == {a: {score: "15", games:0}, b: {score:"love", games:3}}
puts points("bbbbbbbbbbbba")
puts points("aaabbba") == {a: {score: "adv", games:0}, b: {score:"", games:0}}
puts points("aaabbba")
puts points("aaabbbab") == {a: {score: "40", games:0}, b: {score:"40", games:0}}
puts points("aaabbbab")
puts points("aaabbbabb") == {a: {score: "", games:0}, b: {score:"adv", games:0}}
puts points("aaabbbabb")
puts points("aaabbbabbb") == {a: {score: "love", games:0}, b: {score:"love", games:1}}
puts points("aaabbbabbb")
