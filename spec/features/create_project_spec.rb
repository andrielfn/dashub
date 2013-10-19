require 'spec_helper'

feature 'Create repository' do
  scenario 'with success' do
    visit root_path

    click_link 'New project'

    expect(page).to have_content 'Project'

    fill_in 'Name', with: 'Dashub'
    click_button 'Create'

    expect(page).to have_content 'Dashub'
  end

  scenario 'viewing a  project' do
    Project.create(name: 'Dashub')
    visit root_path
    click_link 'Dashub'

    within '#new_repository' do
      fill_in 'Name', with: 'site'
      fill_in 'Description', with: 'main site description'
      fill_in 'Url', with: 'github.com/dashub/demo-project'

      click_button 'Add repository'
    end

    expect(page).to have_content 'site'
    expect(page).to have_content 'main site description'
    expect(page).to have_content 'github.com/dashub/demo-project'
  end
end
