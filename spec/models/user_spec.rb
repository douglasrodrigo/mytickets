require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :name => "Douglas Rodrigo", :email => "douglasrodrigo@gmail.com", :password => "blackfoot", :password_confirmation => "blackfoot" }
    @user = User.create!(@attr)
  end

  it "should create a new instance given valid attributes" do
    @user.should_not be_nil
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject duplicate emails" do
    lambda { User.create!(@attr) }.should raise_error
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end

    it "should reject short passwords" do
      short = "xxx"
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "x" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end

    it "should have an encrypted password" do
      @user.should respond_to(:crypt_password)
    end

    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        authenticated_user = User.authenticate(@attr[:email], @attr[:password])
        authenticated_user.should == @user
      end
    end
  end
end
