require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "must be created with a password and password_confirmation fields" do
      @user = User.new(name: "Bob", email: "bob@bob.com", password: "qwerty", password_confirmation: "qwerty")
      @user.save
      expect(@user).to be_present
    end

    it "returns an error if password and password_confirmation mismatch" do
      @user = User.new(name: "Bob", email: "bob@bob.com", password: "qwerty", password_confirmation: "qwertyu")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "returns an error if password is blank" do
      @user = User.new(name: "Bob", email: "bob@bob.com", password_confirmation: "qwerty")
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "tests if email is not case sensitive" do
      @user1 = User.new(name: "Bob", email: "test@test.COM", password: "qwerty", password_confirmation: "qwerty")
      @user2 = User.new(name: "Bob", email: "TEST@TEST.com", password: "qwerty", password_confirmation: "qwerty")
      @user1.save
      @user2.save
      expect(@user2.id).not_to be_present
    end

    it "returns an error if one of the fields is blank" do
      @user1 = User.new(name: "", email: "bob@bob.com", password: "qwerty", password_confirmation: "qwerty")
      @user2 = User.new(name: "Bob", email: nil, password: "qwerty", password_confirmation: "qwerty")
      @user3 = User.new(name: "Bob", email: "bob@bob.com", password: nil, password_confirmation: "qwerty")
      @user1.save
      @user2.save
      @user3.save
      expect(@user1.id).to be nil
      expect(@user2.id).to be nil
      expect(@user3.id).to be nil
    end

    it "returns an error if the password length is below the minimum" do
      @user = User.new(name: "Bob", email: "bob@bob.com", password: "q", password_confirmation: "q")
      @user.save
      expect(@user.id).not_to be_present
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do 
      @email = "bob@bob.com"
      @password = "qwerty"
      user = User.create(name:"Bob", email: @email, password: @password, password_confirmation: @password)
    end

    describe "Authentication" do 

      it "tests if email with spaces before or/and after it authenticates successfully" do
        user = User.authenticate_with_credentials(" bob@bob.com   ", @password)
        expect(user).to be_a(User)
      end

      it "returns nil when username is invalid" do
        user = User.authenticate_with_credentials("tom@tom.com", @password)
        expect(user).to eq(nil)
      end

      it "returns nil when password is invalid" do
        user = User.authenticate_with_credentials(@email, 'qwert')
        expect(user).to eq(nil)
      end

      it "returns a user when username is not case sensitive" do
        user = User.authenticate_with_credentials("bOb@BoB.cOm", @password)
        expect(user).to be_a(User)
      end

    end

  end

end