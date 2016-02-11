require_relative '../spec_helper.rb'

feature 'Logging in' do
  around(:each) do |example|
    ActiveRecord::Base.connection.transaction do
      user = User.create(
        username: 'peshko123',
        password: '123123')

      example.run

      raise ActiveRecord::Rollback
    end
  end

  scenario 'Redirects to /login if incorrect username is passed' do
    visit '/login'
    fill_in 'username', with: 'peshko1234'
    fill_in 'password', with: '123123'

    click_button 'Login'

    expect(page).to have_current_path('/login')
  end

  scenario 'Redirects to /login if incorrect password is passed' do
    visit '/login'
    fill_in 'username', with: 'peshko123'
    fill_in 'password', with: '1231233'

    click_button 'Login'

    expect(page).to have_current_path('/login')
  end

  scenario 'Redirects to /login if correct username and password are passed' do
    visit '/login'
    fill_in 'username', with: 'peshko123'
    fill_in 'password', with: '123123'

    click_button 'Login'

    expect(page).to have_current_path('/')
  end

  scenario 'Shows user\'s username on index page if correct username and password are passed' do
    visit '/login'
    fill_in 'username', with: 'peshko123'
    fill_in 'password', with: '123123'

    click_button 'Login'

    expect(page).to have_content('Hello, Peshko123')
  end
end
