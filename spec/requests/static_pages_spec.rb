require 'spec_helper'

# describe "StaticPages" do
  # describe "GET /static_pages" do
    # it "works! (now write some real specs)" do
      # # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      # get static_pages_index_path
      # response.status.should be(200)
    # end
  # end
# end

describe "Static pages" do

	let(:base_title) {"Ruby on Rails Tutorial"}
	describe "Home page" do
	
		it "should have the content 'Sample App'" do
			visit root_path
			expect(page).to have_content('Sample App')
		end
		
		it "should have the base title" do
			visit root_path
			expect(page).to have_title("#{base_title}")
		end
		
			
		it "should have the title 'Ruby on Rails Tutorial | Home'" do
			visit root_path
			expect(page).to have_title("Home")
		end
		
	end
	
	describe "Help page" do
	
		it "should have the content 'Help'" do
			visit help_path
			expect(page).to have_content('Help')
		end
		
		it "should have the base title" do
			visit help_path
			expect(page).to have_title("#{base_title}")
		end
		
		it "should have the title 'Ruby on Rails Tutorial | Help'" do
			visit help_path
			expect(page).to have_title("Help")
		end
		
	end
	
	describe "About page" do
	
		it "should have the content 'About us'" do
			visit about_path
			expect(page).to have_content('About Us')
		end
		
		it "should have the base title" do
			visit about_path
			expect(page).to have_title("#{base_title}")
		end
		
		it "should have the title 'Ruby on Rails Tutorial | About Us'" do
			visit about_path
			expect(page).to have_title("About Us")
		end
		
	end
	
	describe "Contact page" do
	
		it "should have the h1 'Contact Us'" do
			visit contact_path
			page.should have_selector('h1',text: 'Contact Us')
		end
		
		it "should have the base title" do
			visit contact_path
			page.should have_title("#{base_title}")
		end
		
		it "should have the title 'Ruby on Rails Tutorial | Contact Us'" do
		visit contact_path
		expect(page).to have_title("Contact Us")
		end
	
	end
	
end

