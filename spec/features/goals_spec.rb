require 'rails_helper'

feature "Can move from goals index to new" do
  context "when logged in" do
    before :each do
      sign_up_as_ginger_baker
      visit '/goals'
    end

    it "goals index has a 'New Goal' link to new goal page" do
      expect(page).to have_content "New Goal"
    end
  end
end

feature "Creating a goal" do
  context "when logged in" do
    before :each do
      sign_up_as_ginger_baker
      visit '/goals/new'
    end

    it "has a new goal page" do
      expect(page).to have_content 'New Goal'
    end

    it "takes a name and a public checkbox" do
      expect(page).to have_content 'Name'
      expect(page).to have_content 'Public'
      expect(page).to have_content 'Private'
    end

    it "validates the presence of name" do
      fill_in 'Name', with: ''
      click_button 'Create New Goal'
      expect(page).to have_content 'New Goal'
      expect(page).to have_content "Name can't be blank"
    end

    it "redirects to the goal show page" do
      fill_in 'Name', with: 'fake_goal'
      choose('public_goal')
      click_button 'Create New Goal'
      expect(current_path).to match(/^\/goals\/(\d)+/)
      expect(page).to have_content 'fake_goal'
    end

    context "on failed save" do
      before :each do
        fill_in 'Name', with: ''
      end

      it "displays the new goal form again" do
        expect(page).to have_content 'New Goal'
      end

      it "still allows for a successful save" do
        fill_in 'Name', with: 'fake_goal'
        choose('public_goal')
        click_button 'Create New Goal'
        expect(page).to have_content 'fake_goal'
      end
    end
  end

  context "when logged out" do
    it "redirects to the login page" do
      visit '/goals/new'
      expect(page).to have_content 'Sign In'
    end
  end
end

#==========

feature "Seeing goals" do
  context "when logged in" do
    before :each do
      sign_up_as_ginger_baker
      make_goal("public_goal_1")
      make_goal("private_goal_1", false)
      click_on "Sign Out"
      sign_up_as_shadowfiend
      make_goal("public_goal_2")
      make_goal("private_goal_2", false)
      visit '/goals'
    end

    it "shows all the public goals for all users and private goals that belong to the current user" do
      expect(page).to have_content 'public_goal_1'
      expect(page).to have_content 'public_goal_2'
      expect(page).to have_content 'private_goal_2'
      expect(page).to_not have_content 'private_goal_1'
    end
#
#
    it "shows the current user's username" do
      expect(page).to have_content 'shadowfiend'
    end

    it "goals to each of the goal's show page via goal titles" do
      click_link 'public_goal_2'
      expect(page).to have_content 'public_goal_2'
      expect(page).to_not have_content 'public_goal_1'
      expect(page).to_not have_content 'private_goal_1'
    end
  end


  context "when logged out" do
    it "redirects to the login page" do
      visit '/goals'
      expect(page).to have_content 'Sign In'
    end
  end

end


feature "Showing a goal" do
  context "when logged in" do
    before :each do
      sign_up('ginger_baker')
      make_goal("public_goal_1")
      visit '/goals'
      click_link 'public_goal_1'
    end

    it "shows the current user's username" do
      expect(page).to have_content 'ginger_baker'
    end

    it "displays the goal name" do
      expect(page).to have_content 'public_goal_1'
    end

    it "displays a link back to the goal index" do
      expect(page).to have_content "Goals Index"
    end
  end
end

feature "Editing a goal" do
  before :each do
    sign_up_as_ginger_baker
    make_goal("public_goal_1")
    make_goal("private_goal_1", false)
    click_on "Sign Out"
    sign_up_as_shadowfiend
    make_goal("public_goal_2")
    visit '/goals'
    # sign_up_as_ginger_baker
    # make_goal("public_goal_1")
    # visit '/goals'
    # click_link 'google'
  end

  it "has a link on the show page to edit a goal" do
    expect(page).to have_content 'Edit Goal'
  end

  it "displays edit goal option ONLY for the goals that belong to the current user" do
    logout
    sign_up_as_necrophos
    expect(page).to have_content 'public_goal_1'
    expect(page).to have_content 'public_goal_2'
    expect(page).to_not have_content 'Edit Goal'
  end


  it "shows a form to edit the goal" do
    click_link 'Edit Goal'
    expect(page).to have_content 'Name'
    expect(page).to have_content 'Public'
    expect(page).to have_content 'Private'
  end

  it "has all the data pre-filled" do
    click_link 'Edit Goal'
    expect(find_field('Name').value).to eq('public_goal_2')
    expect(find_field("public_goal")).to be_checked
  end

  it "shows errors if editing fails" do
    click_link 'Edit Goal'
    fill_in 'Name', with: ''
    click_button 'Update Goal'
    expect(page).to have_content "Edit Goal"
    expect(page).to have_content "Name can't be blank"
  end

  context "on successful update" do
    before :each do
      click_link 'Edit Goal'
    end

    it "redirects to the goal show page" do
      fill_in 'Name', with: 'public_goal_2_updated'
      click_button 'Update Goal'
      expect(page).to have_content 'public_goal_2_updated'
    end
  end
end
