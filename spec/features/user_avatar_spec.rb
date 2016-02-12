require_relative '../spec_helper.rb'

feature 'User Avatar Uploading' do
  around(:each) do |example|
    ActiveRecord::Base.connection.transaction do
      User.create(
        username: 'peshko123',
        password: '123123')

      visit '/login'
      fill_in 'username', with: 'peshko123'
      fill_in 'password', with: '123123'

      click_button 'Login'
      example.run

      raise ActiveRecord::Rollback
    end
  end

  scenario 'Redirects to /user/ if image is uploaded' do
    visit '/user/peshko123/edit'

    avatar = File.join(File.dirname(__FILE__), '/files/test.jpg')

    attach_file 'file', avatar

    click_button 'Upload Image'

    expect(page).to have_current_path('/user/peshko123')
  end

  scenario 'Redirects to /user/edit if exe file is uploaded' do
    visit '/user/peshko123/edit'

    file = File.join(File.dirname(__FILE__), '/files/join.me.exe')

    attach_file 'file', file

    click_button 'Upload Image'

    expect(page).to have_current_path('/user/peshko123/edit')
  end
end
