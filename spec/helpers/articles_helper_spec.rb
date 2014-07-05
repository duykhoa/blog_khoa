require 'rails_helper'

describe ArticlesHelper do
  describe "#encode_url" do
    let(:text) { "$%$@#@!" }
    it "encode text" do
      expect(encode_url(text)).to eq(URI.encode(text))
    end
  end

  describe "#form_search_path" do
    context "params include category_name" do
      let!(:params) { {category_name: 'Marketing Blog'} }

      it "returns path" do
        expect(form_search_path(params)).to eq(category_index_path(params[:category_name]))
      end
    end

    context "params does not include category_name" do
      let!(:params) { {} }

      it "returns path" do
        expect(form_search_path(params)).to eq(search_path)
      end
    end
  end
end
