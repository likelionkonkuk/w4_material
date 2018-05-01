# 오류를 수정하고 주석을 읽고 알맞은 코드를 추가해주세요.

class Person

	# 이름, 공부, 핸드폰 정보를 입력과 출력을 할 수 있어야한다.(초기화시 모두 입력)
	# 단, 핸드폰 정보는 비공개이다.

	attr_writer :name, :study, :phone
	
	def initialize(name)
		@name = name
	end

	def study
		super
		puts "#{@name}가 공부를 합니다."
	end

	def hungry
		puts "#{@name}가 배가 고픕니다."
	end
end

class Developer < Person
	
	# name가 코딩 공부를 합니다로 출력하고 싶다! 어떻게 해야할까?
	# name가 배가 고픕니다. 그래서 name가 초콜릿을 먹었습니다.
	# 개발자는 해커톤에 참여한다.
	# 개발자는 위의 3가지 행동을 합니다.
	def hungry
		puts "그래서 #{@name}가 초콜릿을 먹었습니다."
	end

	
end

d = Developer.new('다혜', '코딩','010-1234-5678')
puts d.name
# 각 메소드 호출하기

# 이름만 자기이름으로 변경하기