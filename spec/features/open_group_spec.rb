require_relative '../spec_helper.rb'

feature 'Open Groups Main Functionality' do
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

  scenario 'Creates open group and redirects to its page' do
    visit '/create_open_group'

    fill_in 'open_group_name', with: 'rubyyy'
    fill_in 'open_group_description', with: 'this is a test group'

    click_button 'Create Open Group'

    expect(page).to have_current_path('/open_group/rubyyy') and
                    have_content('Open Group Admin\'s Username: pesho123')
  end

  scenario 'Can join open group if user is not in group' do
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

    expect(page).to have_content('Join rubyyy group')
  end

  scenario 'Can\'t leave or delete open group if user is not in group' do
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

    expect(page).to have_no_content('Leave rubyyy group')
    expect(page).to have_no_content('Delete rubyyy group')
  end

  scenario 'Can leave but cannot delete open group if user is not admin' do
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

    click_button 'Join rubyyy group'

    expect(page).to have_content('Leave rubyyy group')
    expect(page).to have_no_content('Delete rubyyy group')
  end

  scenario 'Shows open group name on index page after creating it' do
    visit '/create_open_group'

    fill_in 'open_group_name', with: 'rubyyy'
    fill_in 'open_group_description', with: 'this is a test group'

    click_button 'Create Open Group'

    visit '/'

    expect(page).to have_content('rubyyy')
  end

  scenario 'Shows open group name on index page after joining it' do
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

    click_button 'Join rubyyy group'

    visit '/'

    expect(page).to have_content('rubyyy')
  end

  scenario 'Doen\'t show open group name on index page after leaving it' do
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

    click_button 'Join rubyyy group'

    click_button 'Leave rubyyy group'

    visit '/'

    expect(page).to have_no_content('rubyyy')
  end

  scenario 'When admin delete open group all members automatically leave it and its name is not on user\'s index pages' do
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

    click_button 'Join rubyyy group'

    visit '/logout'

    visit '/login'

    fill_in 'username', with: 'pesho123'
    fill_in 'password', with: '123123'

    click_button 'Login'

    visit '/open_group/rubyyy'

    click_button 'Delete rubyyy group'

    visit '/'

    expect(page).to have_no_content('rubyyy')

    visit '/logout'

    visit '/login'

    fill_in 'username', with: 'batkata'
    fill_in 'password', with: '123123'

    visit '/'

    expect(page).to have_no_content('rubyyy')
  end
end
