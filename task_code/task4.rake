# desc 태스크 목록에 커스텀 태스크가 나오게 하기
# rake -T를 하면 보인다.
namespace :fruit do
  desc "Pick a item randomly"
  task :random do
    puts arr.sample
  end

  desc "Pick the first item"
  task :first do
    puts arr.first
  end

  desc "Pick the last item"
  task :last do
    puts arr.last
  end
end