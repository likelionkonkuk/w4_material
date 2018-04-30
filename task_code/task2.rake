# 여러개도 지정할 수 있다.

arr = ["Apple", "Banana", "Orange", "Kiwi"]
task :random_fruit do
  puts arr.sample
end

task :first_fruit do
  puts arr.first
end

task :last_fruit do
  puts arr.last
end

# $ rake random_fruit
# $ rake first_fruit
# $ rake last_fruit