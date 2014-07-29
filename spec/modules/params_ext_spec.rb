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

  describe "#index_params" do
    let!(:params_0) { ActionController::Parameters.new({page: 2}) }
    let!(:params_1) { ActionController::Parameters.new({page: 1}) }
    let!(:params_2) { ActionController::Parameters.new({}) }

    it "returns params include page params" do
      expect(described_class.new.send(:index_params, params_0))
        .to include({page: 2})
    end

    it "returns params without page key" do
      expect(described_class.new.send(:index_params, params_1))
        .not_to include({page: 1})

      expect(described_class.new.send(:index_params, params_2))
        .not_to include({page: 1})
    end
  end

  describe "#search_params" do
    pending
  end

  describe "#category_params" do
    pending
  end
end

describe ArticlesController do
  it_behaves_like "params_ext"
end
