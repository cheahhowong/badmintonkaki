require 'rails_helper'

RSpec.describe Event, :type => :model do
  subject {
    described_class.new(title: "Anything", description: "lorem", start_date: DateTime.now, 
    	start_time: DateTime.now, end_time: DateTime.now + 1.week , address: "dfdfd", city: "Teluk Intan", state: "Perak", 
      postcode: "2323")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a start_date" do
    subject.start_date = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a start_time" do
    subject.start_time = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a end_time" do
    subject.end_time = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a address" do
    subject.address = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a state" do
    subject.state = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a city" do
    subject.city = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a postcode" do
    subject.postcode = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
  it "has many users" do
    assc = described_class.reflect_on_association(:users)
    expect(assc.macro).to eq :has_many
  end

  it "has many relationships" do
    assc = described_class.reflect_on_association(:relationships)
    expect(assc.macro).to eq :has_many
  end
  end

end