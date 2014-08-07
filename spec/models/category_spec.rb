require 'rails_helper'

describe Category, :type => :model do

  it { should validate_numericality_of(:position) }
  it { should validate_uniqueness_of(:position) }

  it "reorder by created at asc" do
    expect(Category.all.to_sql).to eq(Category.reorder('').order(created_at: :asc).to_sql)
  end
end
