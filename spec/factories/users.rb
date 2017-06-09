FactoryGirl.define do
  factory :michael, class: User do
    name 'Michael Example'
    nickname 'michael'
    email 'michael@example.com'
    password 'password'
    admin true
    activated true
    activated_at Time.current
  end

  factory :archer, class: User do
    name 'Sterling Archer'
    nickname 'archer'
    email 'duchess@example.gov'
    password 'password'
    activated true
    activated_at Time.current
  end

  factory :lana, class: User do
    name 'Sterling Lana'
    nickname 'lana'
    email 'lana@example.gov'
    password 'password'
    activated true
    activated_at Time.current
  end

  factory :user, class: User do
    sequence(:name)  {|n| "Person #{n}" }
    sequence(:nickname)  {|n| "person_#{n}" }
    sequence(:email) {|n| "person_#{n}@example.com" }
    password 'password'
    activated true
    activated_at Time.current
  end
end
