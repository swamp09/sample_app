FactoryGirl.define do
  factory :michael, class: User do
    name 'Michael Example'
    email 'michael@example.com'
    password 'password'
    admin true
    activated true
    activated_at Time.current
  end

  factory :archer, class: User do
    name 'Sterling Archer'
    email 'duchess@example.gov'
    password 'password'
    activated true
    activated_at Time.current
  end

  factory :lana, class: User do
    name 'Sterling Lana'
    email 'lana@example.gov'
    password 'password'
    activated true
    activated_at Time.current
  end

  factory :user, class: User do
    sequence(:name)  {|n| "Person #{n}" }
    sequence(:email) {|n| "person_#{n}@example.com" }
    password 'password'
    activated true
    activated_at Time.current
  end
end
