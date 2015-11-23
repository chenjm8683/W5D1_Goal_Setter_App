require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit "/users/new"
  end

  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end
end

feature "signing up a user" do

  it "shows username on the homepage after signup" do
    sign_up_as_ginger_baker
    expect(page).to have_content 'ginger_baker'
  end
end


feature "logging in" do
  before :each do
    visit "/session/new"
  end

  it "shows username on the homepage after login" do
    sign_in_as_ginger_baker
    expect(page).to have_content 'ginger_baker'
  end
end

feature "logging out" do
  before :each do
    visit "/session/new"
  end

  it "begins with logged out state" do
    expect(page).to have_no_content 'ginger_baker'
  end

  it "doesn't show username on the homepage after logout" do
    sign_in_as_ginger_baker
    logout
    expect(page).to have_no_content 'ginger_baker'
  end
end
