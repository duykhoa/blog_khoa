require 'rails_helper'

describe ArticlesHelper do
  describe "#encode_url" do
    let(:text) { "$%$@#@!" }
    it "encode text" do
      expect(encode_url(text)).to eq(URI.encode(text))
    end
  end
end
