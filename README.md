# 4주차 수업자료 OOP + MODEL


## OOP

루비는 객체 지향 프로그래밍언어 입니다.
OOP(Object-Oriented Programming) 객체 지향 프로그래밍에 대해 배워봅시다.

## Model

MVC패턴의 Model을 배워봅시다.

- 모델관계(1:1, 1:N, N:M)
- Faker gem을 사용해 더미 데이터 사용하기
- migration
- validation
- seed
- rake task

---

### 1:N 실습

#### User Model

|id|email|age|created_at|updated_at|
| :--- | :---: | :---: | :---: | :---: |
|integer|string|integer|datetime|datetime|

*has_many posts* : User모델은 Post 모델을 여러개 가지고 있다.

```ruby
$ rails g model User email age:integer
```

#### Post Model

|id|title|content|user_id|created_at|updated_at|
| :--- | :---: | :---: | :---: | :---: | :---: |
|integer|string|text|integer|datetime|datetime|

*belongs_to user* : Post모델은 User모델에 속해있다.

```ruby
$ rails g model Post title content:text user:references
```

#### User.rb

```ruby
class User < ApplicationRecord
  has_many :posts
end
```

#### Post.rb

```ruby
class Post < ApplicationRecord
  belongs_to :user
end
```

#### rails console로 모델 관계 확인

```ruby
Department.new
#=>#<Department id: nil, name: nil, pnum: nil, created_at: nil, updated_at: nil>

d = Department.create name: "개발", pnum: 1234
#=> #<Department id: 1, name: "개발", pnum: 1234, created_at: "2018-04-30 15:41:37", updated_at: "2018-04-30 15:41:37">

Employee.new
#=> #<Employee id: nil, name: nil, enum: nil, department_id: nil, created_at: nil, updated_at: nil>

e=Employee.create name: "dahye", enum: "20180503", department_id: 1
#=> #<Employee id: 1, name: "dahye", enum: 950902, department_id: 1, created_at: "2018-04-30 15:42:49", updated_at: "2018-04-30 15:42:49">

e.department
#=> #<Department id: 1, name: "개발", pnum: 1234, created_at: "2018-04-30 15:41:37", updated_at: "2018-04-30 15:41:37">
```

---

### Migration 실습

- [rails_guides](https://rubykr.github.io/rails_guides/migrations.html)

- 컬럼 추가하기 / 삭제하기
```
만약 마이그레이션 이름이 “AddXXXToYYY” 혹은 “RemoveXXXFromYYY” 이고 이후에 컬럼 이름과 타입을 입력하면 정확한 add_column 과 remove_column 구문이 생성될 것입니다.
```

```
$ rails g migration AddSchoolToUser school
```

```
$ rails g migration RemoveContextFromPost context:text
```


----
### validates 실습

- [rails_guide](http://guides.rubyonrails.org/active_record_validations.html)

```ruby
validates field [, ...] name: params[, ...]
# field : 검사대상필드이름
# name : 검사이름
# params :검사 매개변수
```

#### app/models/user.rb

```ruby
class User < ApplicationRecord
  has_many :posts

  def name=(s)
    super s.titleize
  end
  
  RegExp = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, length: {maximum: 100}, presence: true
  validates :age, numericality: {only_integer: true, greater_than: 19, less_than:30}, presence: true
  validates :email, format: {with: RegExp}, uniqueness: {case_sensitive: false}, presence: true
end
```

#### app/models/post.rb

```ruby
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  words = ["shit", "fuck", "hell"]
  
  before_save{ 
    words.each do |word| 
      len = word.length
      self.content.gsub!(/#{word}/, '*'*len) if(self.content.include?(word))
    end
  }

  validates :title, length: {minimum: 2 , maximum: 30}, presence: true
  validates :content, presence: true
end
```


### Task

#### task 파일 생성

```
$ rails g task my_task test1 test2
     create  lib/tasks/my_task.rake
```

#### task 파일 실행
```
$ rake my_task:test1
$ rake my_task:test2

# 한번에 다 실행하기
$ rake -T | grep my_task
```


---

### 참고자료

- [Rails Active Record](http://guides.rubyonrails.org/association_basics.html)
- [Rails Active Record Validations](http://guides.rubyonrails.org/active_record_validations.html)
- [rubygems](https://rubygems.org)
- [Faker](https://github.com/stympy/faker)
- [rails_db](https://github.com/igorkasyanchuk/rails_db)


---

## Author

written by [정다혜](https://dh00023.github.io).

![](https://avatars.githubusercontent.com/dh00023?v=2&s=100)

<a href="https://dh00023.github.io" target="_blank" class="btn btn-black"><i class="fa fa-github fa-lg"></i> Visit on Github Page &rarr;</a>
