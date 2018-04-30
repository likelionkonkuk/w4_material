# 데이터 베이스자료 불러오기

namespace :fruit do
  task :random => :environment do
    puts Fruit.all.sample.name
  end

  task :first => :environment do
    puts Fruit.first.name
  end

  task :last => :environment do
    puts Fruit.last.name
  end
end