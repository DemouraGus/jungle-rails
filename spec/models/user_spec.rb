require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with all required fields' do
      user = User.new(
        first_name: 'Paul',
        last_name: 'Tato',
        email: 'paul@tato.com',
        password: 'lapatate',
        password_confirmation: 'lapatate'
      )
      expect(user).to be_valid
    end

    it 'requires a password and password_confirmation' do
      user = User.new(
        first_name: 'Paul',
        last_name: 'Tato',
        email: 'paul@tato.com',
        password: nil,
        password_confirmation: nil
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'requires password and password_confirmation to match' do
      user = User.new(
        first_name: 'Paul',
        last_name: 'Tato',
        email: 'paul@tato.com',
        password: 'lapatate',
        password_confirmation: 'elpotato'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'requires a unique email(case insensitive)' do
      User.create(
        first_name: 'Paul',
        last_name: 'Tato',
        email: 'paul@tato.com',
        password: 'lapatate',
        password_confirmation: 'lapatate'
      )
      duplicate_user = User.new(
        first_name: 'Paul',
        last_name: 'Tato',
        email: 'PAUL@TATO.COM',
        password: 'lapatate',
        password_confirmation: 'lapatate'
      )
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'requires an email' do
      user = User.new(
        first_name: 'Paul',
        last_name: 'Tato',
        email: nil,
        password: 'lapatate',
        password_confirmation: 'lapatate'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'requires a first name' do
      user = User.new(
        first_name: nil,
        last_name: 'Tato',
        email: 'paul@tato.com',
        password: 'lapatate',
        password_confirmation: 'lapatate'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'requires a last name' do
      user = User.new(
        first_name: 'Paul',
        last_name: nil,
        email: 'paul@tato.com',
        password: 'lapatate',
        password_confirmation: 'lapatate'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'requires the password to have at least 6 characters' do
      user = User.new(
        first_name: 'Paul',
        last_name: 'Tato',
        email: 'paul@tato.com',
        password: 'lapa',
        password_confirmation: 'lapa'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        first_name: 'Paul',
        last_name: 'Tato',
        email: 'paul@tato.com',
        password: 'lapatate',
        password_confirmation: 'lapatate'
      )
    end

    it 'authenticates with valid email and password' do
      authenticated_user = User.authenticate_with_credentials('paul@tato.com', 'lapatate')
      expect(authenticated_user).to eq(@user)
    end

    it 'authenticates nil for invalid email' do
      authenticated_user = User.authenticate_with_credentials('paul@mato.com', 'lapatate')
      expect(authenticated_user).to be_nil
    end

    it 'authenticates nil for invalid password' do
      authenticated_user = User.authenticate_with_credentials('paul@tato.com', 'lapatat')
      expect(authenticated_user).to be_nil
    end

    it 'authenticates even with leading/trailing spaces in the email' do
      authenticated_user = User.authenticate_with_credentials('   paul@tato.com  ', 'lapatate')
      expect(authenticated_user).to eq(@user)
    end

    it 'authenticates even with incorrect case in the email' do
      authenticated_user = User.authenticate_with_credentials('PAUL@MATO.COM', 'lapatate')
      expect(authenticated_user).to be_nil
    end
  end
end
