require 'rails_helper'

RSpec.describe Relationship, :type => :model do
  subject {
    user = User.new(first_name: "dfdf", last_name: "dfd", email: "232@dfd.com", password: "123f")
    user.save
    event = Event.new(start_date: DateTime.now, start_time: DateTime.now, end_time: DateTime.now + 1.week, 
      address: "dfdfd", city: "Teluk Intan", state: "Perak", postcode: "2323")
    event.save
    described_class.new(user_id: user.id, event_id: event.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a user_id" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a event_id" do
    subject.event_id = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
  it "belongs to user" do
    assc = described_class.reflect_on_association(:user)
    expect(assc.macro).to eq :belongs_to
  end

  it "belongs to event" do
    assc = described_class.reflect_on_association(:event)
    expect(assc.macro).to eq :belongs_to
  end
  end
  
end