require 'rails_helper'

describe ApplicationHelper do
  it "format date" do
    expect(format_date('2013-12-20').class == String).to be true
  end
end
