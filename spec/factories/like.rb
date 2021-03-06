FactoryGirl.define do 
  factory :pin_like, class: Like do
    registered_user
    association :target, factory: :pin
  end

  factory :comment_like, class: Like do
    registered_user
    association :target, factory: :comment
  end

  factory :board_like, class: Like do
    registered_user
    association :target, factory: :board
  end

end
