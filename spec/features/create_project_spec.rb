require 'spec_helper'

feature 'Create repository' do
  scenario 'with success' do
    visit root_path

    click_link 'Create new project'

    expect(page).to have_content 'Create a new project'

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
      fill_in 'Url', with: 'github.com/dashub/dashub'

      click_button 'Add repository'
    end

    expect(page).to have_content 'site'
    expect(page).to have_content 'main site description'
    expect(page).to have_content 'github.com/dashub/dashub'
  end
end
