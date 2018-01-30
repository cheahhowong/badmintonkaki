require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
    described_class.new(first_name: "Anything", last_name: "lorem", email: "zzz@example.com", 
    	phone: "12345", address: "asfdsf", city: "Teluk Intan", state: "Perak", postcode: "2323",
    	password: "5678")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a first_name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last_name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
  it "has many authentications" do
    assc = described_class.reflect_on_association(:authentications)
    expect(assc.macro).to eq :has_many
  end

  it "has many relationships" do
    assc = described_class.reflect_on_association(:relationships)
    expect(assc.macro).to eq :has_many
  end

  it "has many events" do
    assc = described_class.reflect_on_association(:events)
    expect(assc.macro).to eq :has_many
  end
  end

  describe "Generate token" do
    it "should generate a auth_token when user click remember_me button" do
      user = User.new(first_name: "dfdf", last_name: "dfd", password: "some_password", email: "sdfds@example.com", auth_token: "")
      user.save
      expect(user.auth_token).not_to be_empty
    end
  end

  describe "Generate fb token" do
   it "should return fb token if authentication exists" do
     user = User.new(first_name: "dfdf", last_name: "dfd", password: "some_password", email: "sdfds@example.com")
     user.save
     authentication = Authentication.new(provider: "facebook", token: "12345", user_id: user.id)
     authentication.save
     expect(user.fb_token).to eq("12345")
   end

   it "should not return fb token if authentication is not exist" do
     user = User.new(first_name: "dfdf", last_name: "dfd", password: "some_password", email: "sdfds@example.com")
     user.save
     authentication = Authentication.new(provider: "google", token: "12345", user_id: user.id)
     authentication.save
     expect(user.fb_token).to be_nil
   end
 end

end

