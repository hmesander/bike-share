require 'rails_helper'

describe 'Visitor' do
  describe 'visits homepage' do
    it 'they sign up to be a registered user' do
      visit '/'

      within '.container-fixed' do
        click_on "CreateAccount"
      end

      expect(current_path).to eq(new_user_path)

      fill_in 'user[name]', with: 'Bob'
      fill_in 'user[username]', with: 'bobbyboy'
      fill_in 'user[password]', with: 'password'

      click_on "Create Account"

      expect(page).to have_content('Logged in as: Bob')
    end
  end
end
