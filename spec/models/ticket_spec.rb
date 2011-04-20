require 'spec_helper'

describe Ticket do
  before(:each) do
    @user = User.create!(:name => "Douglas Rodrigo", :email => "douglasrodrigo@gmail.com", :password => "blackfoot", :password_confirmation => "blackfoot")
    @attr = {:ticket_id => "334455dd", :description => "some description", :revision => 3.days.from_now, :ok => false}
    @ticket = @user.tickets.create!(@attr)
  end

  it "should create a new instance given valid attributes" do
    @ticket.should_not be_nil
  end

  it "should require a ticket_id" do
    no_ticket_id = Ticket.new(@attr.merge(:ticket_id => ""))
    no_ticket_id.should_not be_valid
  end

  it "should require a user_id" do
    no_user_id = Ticket.new(@attr)
    no_user_id.should_not be_valid
  end

  it "should require a description" do
    no_description = Ticket.new(@attr.merge(:description => ""))
    no_description.should_not be_valid
  end

  it "should require a revision" do
    no_revision = Ticket.new(@attr.merge(:revision => nil))
    no_revision.should_not be_valid
  end
end
