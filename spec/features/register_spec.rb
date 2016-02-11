require_relative '../spec_helper.rb'

feature 'Registration' do
  around(:each) do |example|
    ActiveRecord::Base.connection.transaction do

      example.run

      raise ActiveRecord::Rollback
    end
  end

  scenario 'Redirects to / if registration was successful' do
    visit '/register'

    fill_in 'username', with: 'peshko123'
    fill_in 'password', with: '123123'
    fill_in 'password2', with: '123123'

    click_button 'Register'

    expect(page).to have_current_path('/')
  end

  scenario 'Shows user\'s username on index page if registration was successful' do
    visit '/register'

    fill_in 'username', with: 'peshko123'
    fill_in 'password', with: '123123'
    fill_in 'password2', with: '123123'

    click_button 'Register'

    expect(page).to have_content('Hello, Peshko123')
  end

  scenario 'Redirects to / if existing username is passed' do
    user = User.create(username: 'peshko123', password: '123123')

    visit '/register'

    fill_in 'username', with: 'peshko123'
    fill_in 'password', with: '123123'
    fill_in 'password2', with: '123123'

    click_button 'Register'

    expect(page).to have_current_path('/register')
  end
end
