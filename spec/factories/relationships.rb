FactoryGirl.define do
  factory :one, class: Relationship do
    follower 1
    followed 3
  end

  factory :two, class: Relationship do
    follower_id 1
    followed_id 3
  end

  factory :three, class: Relationship do
    follower_id 3
    followed_id 1
  end

  factory :four, class: Relationship do
    follower_id 2
    followed_id 1
  end
end
