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
end
