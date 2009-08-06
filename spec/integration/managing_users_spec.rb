require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Managing Users" do
  before(:each) do
    @valid_attributes = {
      :username => "value for username",
      :email => "value for email",
      :password => "value for password"
    }
  end

  describe "viewing index" do
    it "lists all Users" do
      user = User.create!(@valid_attributes)
      visit users_path
      response.should have_selector("a", :href => user_path(user))
    end
  end
end
