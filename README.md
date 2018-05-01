# 4주차 수업자료 OOP + MODEL


## OOP

루비는 객체 지향 프로그래밍언어 입니다.
OOP(Object-Oriented Programming) 객체 지향 프로그래밍에 대해 배워봅시다.

## MODEL

MVC패턴의 Model을 배워봅시다.

- 모델관계(1:1, 1:N, N:M)
- Faker gem을 사용해 더미 데이터 사용하기
- migration
- validation
- seed
- rake task

#### 유의사항

- unilion W4강의를 들었다는 가정하에 진행됩니다.
- ruby `2.4.0` rails `5.0.6` 버전 맞춰주세요.

---
### 다운로드링크

- [수업자료 다운받기](https://github.com/likelionkonkuk/w4_material)

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
$ rails g model Post title content:text user_id:integer
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
User.create name: "다혜", age: 24, email: 'dh0023@likelion.org'
#=> #<User id: 1, name: "다혜", age: 24, email: "dh0023@likelion.org", created_at: "2018-05-01 12:55:57", updated_at: "2018-05-01 12:55:57">

Post.create title: "안녕하세요!", content: "asdfkjasldkfjsdlkfjasd", user_id: 1
#=> #<Post id: nil, title: "안녕하세요!", content: "asdfkjasldkfjsdlkfjasd", user_id: 1, created_at: "2018-05-01 12:56:40", updated_at: "2018-05-01 12:56:40>

u  = User.first
u.posts
p = Post.first
p.user
```

#### Comment Model

|id|content|post_id|created_at|updated_at|
| :--- | :---: | :---: | :---: | :---: |
|integer|text|integer|datetime|datetime|
 
post모델과 1:N관계를 갖고 있는 comment 모델을 생성할 것이다. 앞에서는 `post_id:integer`로 생성했지만 여기서는 더 간단하게 해보자!

```
$ rails g model Comment content:text post:references
```

이미 Post.rb에서 belongs_to 관계는 설정 된 것을 확인할 수 있다.

```rb
# Comment.rb
has_many :comments
```

console로 확인해보자!

```ruby
Comment.creat content: "aksdfjlaskdfjlaskd", post_id: 1
#=> #<Comment id: 1, content: "aksdfjlaskdfjlaskd", post_id: 1, created_at: "2018-05-01 13:06:21", updated_at: "2018-05-01 13:06:21">

a=Comment.first
#=> #<Comment id: 1, content: "aksdfjlaskdfjlaskd", post_id: 1, created_at: "2018-05-01 13:06:21", updated_at: "2018-05-01 13:06:21">

a.post
#=> #<Post id: 1, title: "안녕하세요!", content: "asdfkjasldkfjsdlkfjasd", user_id: 1, created_at: "2018-05-01 12:56:40", updated_at: "2018-05-01 12:56:40">

a.post.user
#=> #<User id: 1, name: "다혜", age: 24, email: "dh0023@likelion.org", created_at: "2018-05-01 12:55:57", updated_at: "2018-05-01 12:55:57">

p=Post.first
#=> #<Post id: 1, title: "안녕하세요!", content: "asdfkjasldkfjsdlkfjasd", user_id: 1, created_at: "2018-05-01 12:56:40", updated_at: "2018-05-01 12:56:40">
p.comments
#=> #<ActiveRecord::Associations::CollectionProxy [#<Comment id: 1, content: "aksdfjlaskdfjlaskd", post_id: 1, created_at: "2018-05-01 13:06:21", updated_at: "2018-05-01 13:06:21">]>
---
```

---

### Migration 실습

- [rails_guides](https://rubykr.github.io/rails_guides/migrations.html)

```
만약 마이그레이션 이름이 “AddXXXToYYY” 혹은 “RemoveXXXFromYYY” 이고 이후에 컬럼 이름과 타입을 입력하면 정확한 add_column 과 remove_column 구문이 생성될 것입니다.
```

#### 컬럼 추가하기

```
$ rails g migration AddSchoolToUser school
      invoke  active_record
      create    db/migrate/20180501134312_add_school_to_user.rb
```

```rb
class AddSchoolToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :school, :string
  end
end
```
```
$ rails db:migrate
```
한 후 `rails_db`나 console을 이용해서 확인 해보면 추가가 된 것을 확인 할 수 있다.

```rb
User.new
#=> #<User id: nil, name: nil, age: nil, email: nil, created_at: nil, updated_at: nil, school: nil>
```

#### 컬럼 삭제하기

```
$ rails g migration RemoveSchoolFromUser school
      invoke  active_record
      create    db/migrate/20180501134630_remove_school_from_user.rb
```

```ruby
class RemoveSchoolFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :school, :string
  end
end
```

```
$ rails db:migrate
```
```ruby
User.new
#=> #<User id: nil, name: nil, age: nil, email: nil, created_at: nil, updated_at: nil>
```

---

### Faker Gem

그런데 이렇게 데이터를 한개 한개 입력하기가 너무 힘들다. 레일즈에서는 더미 데이터 생성을 도와주는 gem이 있다.

- [Faker](https://github.com/stympy/faker)


----
### validates 실습

- [rails_guide](http://guides.rubyonrails.org/active_record_validations.html)

```ruby
validates field [, ...] name: params[, ...]
# field : 검사대상필드이름
# name : 검사이름
# params :검사 매개변수
```

모델 저장(save), 생성(create), 수정(update) 메소드가 호출되는 시점에 입력값을 검사처리해 검사가 성공적으로 이루어 지는 경우에만 수행된다.


| 유효성 검사 종류 | 설명                         |
| ---------------- | ---------------------------- |
| uniqueness       | 중복검사                     |
| presence         | 값이 존재하는지 검사         |
| numericality     | 숫자인지 검사                |
| format           | 정규표현식과 일치하는지 검사 |
| length           | 길이 검사                    |


#### app/models/user.rb

1. 이메일 형식이 맞아야한다.
2. 이름, 나이, 이메일은 입력되지 않으면 저장되지 않는다.
3. 이메일은 유일해야한다.
4. 나이는 19세 이상이어야한다.
5. 게시글 제목에는 like와 lion이 들어가면 글자 길이만큼 `*`로 변경되어야 하며 길이는 최대 30자이다.

```ruby
class User < ApplicationRecord
  has_many :posts
    
  RegExp = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true
  validates :age, numericality: {only_integer: true, greater_than: 19}, presence: true
  validates :email, format: {with: RegExp}, uniqueness: {case_sensitive: false}, presence: true
end
```

#### app/models/post.rb

```ruby
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  words = ["like", "lion"]
  
  before_save{ 
    words.each do |word| 
      len = word.length
      self.content.gsub!(/#{word}/, '*'*len) if(self.content.include?(word))
    end
  }

  validates :title, length: {maximum: 30}
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
