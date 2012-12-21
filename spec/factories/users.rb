# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    uid "MyString"
    token "MyString"
    expire 1
    email "MyString"
    first_name "MyString"
    last_name "MyString"
  end
end
