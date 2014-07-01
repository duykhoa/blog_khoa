require 'rails_helper'

describe Article do
  it { should belong_to(:category) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:title) }

  describe "#article_url" do
    let!(:article) { FactoryGirl.build(:article) }
    it 'returns an url with title' do
      expect(article.article_url).to eq([:title])
    end
  end
end
