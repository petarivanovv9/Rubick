require_relative '../spec_helper.rb'

feature 'Open Groups Post Functionality' do
  around(:each) do |example|
    ActiveRecord::Base.connection.transaction do

      User.create(
        username: 'pesho123',
        password: '123123')

      visit '/login'
      fill_in 'username', with: 'pesho123'
      fill_in 'password', with: '123123'

      click_button 'Login'
      example.run

      raise ActiveRecord::Rollback
    end
  end

  scenario 'Can post if user is admin' do
    visit '/create_open_group'

    fill_in 'open_group_name', with: 'rubyyy'
    fill_in 'open_group_description', with: 'this is a test group'

    click_button 'Create Open Group'

    visit '/open_group/rubyyy'

    expect(page).to have_content('Create Post')
  end

  scenario 'Can\'t post if user is not in group' do
    visit '/create_open_group'

    fill_in 'open_group_name', with: 'rubyyy'
    fill_in 'open_group_description', with: 'this is a test group'

    click_button 'Create Open Group'

    visit '/logout'

    visit '/register'
    fill_in 'username', with: 'batkata'
    fill_in 'password', with: '123123'
    fill_in 'password2', with: '123123'

    click_button 'Register'

    visit '/open_group/rubyyy'

    expect(page).to have_no_content('Create Post')
  end
end
