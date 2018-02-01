require 'rails_helper'

describe "the signin process", :type => :feature do

 it "signs me in" do
   a = User.create(first_name: 'aaa', last_name: 'bbb', email: 'ppap@example.com', password: 'password')
   visit '/users/get_sign_in'
   within("#sign-in") do
     fill_in 'Email', with: 'ppap@example.com'
     fill_in 'Password', with: 'password'
   end
   click_button "Sign In"
   expect(page).to have_current_path("/users/#{a.id}")
 end
end
