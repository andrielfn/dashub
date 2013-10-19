require 'spec_helper'

feature 'Associate repositories to project' do
  let!(:project) { projects(:first) }

  scenario 'with success' do
    visit new_project_repository_path(project)

    fill_in 'Url', with: 'rails'
    click_on 'Create Repository'

    expect(page).to have_content('Repository created successfully.')
    expect(page).to have_content('rails')
  end
end
