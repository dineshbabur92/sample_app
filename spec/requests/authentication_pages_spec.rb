require 'spec_helper'

# describe "AuthenticationPages" do
  # describe "GET /authentication_pages" do
    # it "works! (now write some real specs)" do
      # # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      # get authentication_pages_index_path
      # response.status.should be(200)
    # end
  # end
# end

describe "Authentication" do
    subject { page }
    
    describe "sign in page" do
        before { visit signin_path }
        
        it { should have_selector('h1', text: 'Sign in') }
        it { should have_title('Sign in') }
       
    end
    
    describe "sign in" do
        before { visit signin_path }
        describe "with invalid information" do
            before{ click_button "Sign in" }
            
            it{ should have_title('Sign in') }
            it{ should have_selector('div.alert.alert-error', text: 'Invalid')}
            
            describe "after that visit home page" do
                before{ click_link "Home" }
                
                it{ should_not have_selector('div.alert.alert-error') }
            end    
                
        end
        describe "with valid information" do
          let(:user) { FactoryGirl.create(:user) }
          before do
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"
          end
          
          it{ should have_title( user.name ) }
          it{ should have_link( 'Profile',href: user_path(user) ) }
		  it{ should have_link( 'Settings', href: edit_user_path(user)) }
          it{ should have_link( 'Sign out',href: signout_path) }
          it{ should_not have_link( 'Sign in',href: signin_path ) }
          
          describe "followed by signout " do
            before do
                click_link 'Sign out'
            end
            it{ should have_link('Sign in') }
          end
        end
    end  
		describe "authorization" do
			describe "for non-signed-in users" do
				let(:user) { FactoryGirl.create(:user) }
				
				describe "in the Uses controller" do
					describe "visiting the edit page" do
						before { visit edit_user_path(user) }
						it {should have_title("Sign in")}
					end
					describe "submitting to the update action" do
						before { put user_path(user) }
						specify{ response.should redirect_to(signin_path) }
					end
					describe "visiting the user index page" do
						before {visit users_path}
						it {should have_title("Sign in")}
					end
				end
				
				
				
				describe "when attempting to visit a protected page" do
					before do
						visit edit_user_path(user)
						fill_in "Email", with: user.email
						fill_in "Password", with: user.password
						click_button "Sign in"
					end
					describe "after signing in" do
						it "should render the desired protected page" do
							page.should have_title("Edit user")
						end
					end
				end	
			end
			
			describe "as wrong user" do
				let(:user) { FactoryGirl.create(:user) }
				let(:wrong_user) { FactoryGirl.create(:user, email: "wrong_user@example.com") }
				
				describe "visit users edit page" do
					before { visit edit_user_path(wrong_user) }
					it { should_not have_title("Edit user")}
				end
				
				describe "update info of wrong user" do
					before { put user_path(wrong_user) }
					specify{ response.should redirect_to(root_path) }
				end
			end
		end
end
