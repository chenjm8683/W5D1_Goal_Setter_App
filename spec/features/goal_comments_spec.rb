require 'rails_helper'

feature "Adding comments to goal" do
  before :each do
    sign_up_as_ginger_baker
    make_goal("fake_goal_1")
    click_link("fake_goal_1")
  end

  it "there is an add goal comment form on the goal show page" do
    expect(page).to have_content 'Add Goal Comment'
  end

  it "after submitting comment; new comment is added to list" do
    fill_in 'Comment', with: 'yippy-chai-eh'
    click_button 'Add Comment'
    expect(page).to have_content 'yippy-chai-eh'
  end

  it "validates presence of comment body" do
    click_button 'Add Comment'
    expect(page).to have_content "Body can't be blank"
  end
end

feature "Deleting comments" do
  before :each do
    sign_up_as_ginger_baker
    make_goal("fake_goal_1")
    click_link("fake_goal_1")
    fill_in 'Comment', with: "there are 10 kinds of people. Those who understand binary and those who dont."
    click_button "Add Comment"
  end

  it "displays a remove button next to each comment" do
    expect(page).to have_button 'Remove Comment'
  end

  it "shows the goals index page on click" do
    click_button 'Remove Comment'
    expect(page).to have_content 'ginger_baker'
  end

  it "removes the comment on click" do
    click_button 'Remove Comment'
    expect(page).to_not have_content 'there are 10 kinds of people. Those who understand binary and those who dont.'
  end
end
