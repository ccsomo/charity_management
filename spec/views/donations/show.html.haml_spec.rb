require 'spec_helper'

describe "donations/show" do
  before(:each) do
    @donation = assign(:donation, stub_model(Donation))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
