# 오류를 수정하고 주석을 읽고 알맞은 코드를 추가해주세요.

class Person

	# 이름, 핸드폰 정보를 입력과 출력을 할 수 있어야한다.(초기화시 모두 입력)
	# 단, 핸드폰 정보는 비공개이다.(입력은 받을 수 있으나 출력은 불가능)

	attr_writer 
	
	def initialize(name)
		@name = name
	end

	def study
		puts "#{@name}가 공부를 합니다."
	end

	def hungry
		puts "#{@name}가 배가 고픕니다."
	end
end

class Developer < Person

	# 이름, 핸드폰 정보, 공부할 대상을 입력과 출력을 할 수 있어야한다.(초기화시 모두 입력)
	
	# name가 시험 공부를 합니다로 출력하고 싶다! 어떻게 해야할까?(시험은 입력을 받아서 한다.)
	# name가 배가 고픕니다.(부모 클래스꺼 그대로 사용) 그래서 name가 초콜릿을 먹었습니다.
	# 개발자는 해커톤에 참여한다.(자식 클래스 메소드)
	# 개발자는 위의 3가지 행동을 합니다.
	def hungry
		puts "그래서 #{@name}가 초콜릿을 먹었습니다."
	end

	
end
p=Person.new('현경','010-1111-1111')
d = Developer.new('현진','010-1234-5678', '시험')
# 각 변수 출력
puts p.name




# 각 메소드 호출하기
p.study




# 이름만 자기이름으로 변경하기