# 코드 재사용을 위해서 함수로 분리

namespace :fruit do
  task :random => :environment do
    puts random_fruit
  end

  task :first => :environment do
    puts first_fruit
  end

  task :last => :environment do
    puts last_fruit
  end

  def random_fruit
    Fruit.all.sample.name
  end

  def first_fruit
    Fruit.all.first.name
  end

  def last_fruit
    Fruit.all.last.name
  end
end
