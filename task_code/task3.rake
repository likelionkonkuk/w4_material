# 비슷한 태스크들은 네임스페이스로 묶을 수 있다. 

arr = ["Apple", "Banana", "Orange", "Kiwi"]
namespace :fruit do
  task :random do
    puts arr.sample
  end

  task :first do
    puts arr.first
  end

  task :last do
    puts arr.last
  end
end

# $ rake fruit:random
# $ rake fruit:first
# $ rake fruit:last