require 'rails_helper'

describe ApplicationHelper do
  describe "format date" do
    it "returns a date with format" do
      expect(format_date('2013-12-20').class == String).to be true
    end
  end
end
