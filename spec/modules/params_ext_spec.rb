require 'rails_helper'

shared_examples_for "params_ext" do
  describe "#sanitize_params" do
    it "gsub all non word characters" do
      expect(described_class.new.send(:sanitize_params, "this^is*&|990params"))
        .to eq("this-is-star-and-990params")
    end

    it "retuns '-' if no params passed in" do
      expect(described_class.new.send(:sanitize_params, nil))
        .to eq("-")
    end
  end
end

describe ArticlesController do
  it_behaves_like "params_ext"
end
