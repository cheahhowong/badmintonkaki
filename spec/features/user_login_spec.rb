describe "the signin process", :type => :feature do
 before :each do
   a = User.create(first_name: 'aaa', last_name: 'bbb', email: 'user@example.com', password: 'password')
 end

 it "signs me in" do
   visit '/users/get_sign_in'
   within(".sign-in") do
     fill_in 'Email', with: 'user@example.com'
     fill_in 'Password', with: 'password'
   end
   click_button 'Sign in'
   expect(page).to have_current_path('/users/#{a.id}')
 end
end
