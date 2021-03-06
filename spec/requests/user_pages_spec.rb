require 'spec_helper'

describe "User pages" do
	subject{ page }
	describe "Sign up" do
		before { visit signup_path }
		
		it { should have_selector( 'h1', text: 'Sign up' )}
		it { should have_title( 'Sign up' ) }
		
		let(:submit) { "Create my account" }
		
		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end
		
		describe "with valid information" do
			before do
				fill_in "Name", with: "Example User"
				fill_in "Email", with: "user@example.com"
				fill_in "Password", with: "foobar"
				fill_in "Confirmation", with: "foobar"
			end
			it "should create a user" do
				expect{ click_button submit }.to change(User, :count).by(1)
			end
            ############## see why this did not work##################
            #describe "after saving the user" do
            #   it{ should have_link('Sign out') }
           #end
		end
        describe "after saving the user" do
          before do
            fill_in "Name", with:"something"
            fill_in "Email", with: "something@somethingtest.com";
            fill_in "Password", with: "something"
            fill_in "Confirmation", with: "something"
            click_button "Create my account"
          end
          it{ should have_link( 'Sign out' ) }
        end
          
    end
        
	
	
	describe "Profile Page" do
		let(:user) { FactoryGirl.create(:user) }
		before{	visit user_path(user) }
		
		it{	should have_selector('h1',text: user.name )}
		it{ should have_title(user.name)}
        
	end
	
	describe "edit and update tests" do
		describe "edit" do
			let(:user){ FactoryGirl.create(:user)}
			before do
				sign_in user
				visit edit_user_path(user)
			end
			
			describe "page" do
				it { should have_selector("h1", "Update your profile") }
				it { should have_title("Edit user") }
				it { should have_link("change", href: "http://gravatar.com/emails" )}
			end
			
			describe "with invalid information" do
				before { click_button "Save changes" }
				
				it { should have_content("error") }
			end
			
			describe "with valid information" do
				let(:new_name) {"New Name"}
				let(:new_email){"new@example.com"}
				
				before do
					fill_in "Name", with: new_name
					fill_in "Email", with: new_email
					fill_in "Password", with: user.password
					fill_in "Confirm Password", with: user.password
					click_button "Save changes"
				end
				
				it { should have_title(new_name) }
				it { should have_selector("div.alert.alert-sucess") }
				it{ should have_link("Sign out", href: signout_path)}
				specify{ user.reload.name.should == new_name }
				specify{ user.reload.email.should == new_email }
			end
		end
	end
    
  # describe "GET /user_pages" do
    # it "works! (now write some real specs)" do
      # # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      # get user_pages_index_path
      # response.status.should be(200)
    # end
  # end
end
