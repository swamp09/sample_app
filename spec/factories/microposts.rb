FactoryGirl.define do
  factory :orange, class: Micropost do
    content 'I just ate an orange'
    user_id 1
    created_at 10.minutes.ago
  end

  factory :tau_manifesto, class: Micropost do
    content 'Check out the @tauday site by @mhartl: http://tauday.com'
    user_id 1
    created_at 3.years.ago
  end

  factory :cat_video, class: Micropost do
    content 'Sad cats are sad: http://youtu.be/PKffm2uI4dk'
    user_id 1
    created_at 10.minutes.ago
  end

  factory :most_recent, class: Micropost do
    content 'Writing a short test'
    user_id 1
    created_at Time.current
  end

  factory :ants, class: Micropost do
    content "Oh, is that what you want? Because that's how you get ants!"
    user_id 2
    created_at 2.years.ago
  end

  factory :micropost, class: Micropost do
    sequence(:content) {|n| Faker::Lorem.sentence(n) }
    user_id 1
    created_at 42.days.ago
  end
end
