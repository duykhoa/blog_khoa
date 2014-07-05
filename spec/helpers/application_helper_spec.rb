require 'rails_helper'

describe ApplicationHelper do
  describe "format date" do
    it "returns a date with format" do
      expect(format_date('2013-12-20').class == String).to be true
    end
  end

  describe "#pagination_previous" do
    let!(:articles) { nil }

    before do
      allow(self).to receive(:url_for).and_return(root_path)
    end

    context "page is greater than 1" do
      let!(:page) { 2 }

      it "returns previous page link" do
        result = pagination_previous(articles, page)
        expect(result).to match(/\<div\s+class=.*previous.*\<\/div\>/)
      end
    end

    context "page is eq 1" do
      let!(:page) { 1 }

      it "does not return previous page link" do
        result = pagination_previous(articles, page)
        expect(result).to be_nil
      end
    end
  end

  describe "#pagination_next" do
    let!(:articles) { double("Article") }

    before do
      allow(self).to receive(:url_for).and_return(root_path)
      allow(articles).to receive(:total_count).and_return(100)
      allow(self).to receive(:total_page).and_return(3)
    end

    context "page is less than total page" do
      let!(:page) { 2 }

      it "returns link to next page" do
        result = pagination_next(articles, page)
        expect(result).to match(/\<div\s+class=.*next.*\<\/div\>/)
      end
    end

    context "page is equal to total page " do
      let!(:page) { 3 }

      it "does not return next page link" do
        result = pagination_next(articles, page)
        expect(result).to be_nil
      end
    end
  end

  describe "#total_page" do
    let(:total) { 10 }

    before do
      stub_const('Article::PER_PAGE', 4)
    end

    it "returns total page" do
      expect(total_page(total)).to eq(3)
    end
  end
end
