require 'rails_helper'

describe Category, :type => :model do
  it "reorder by created at asc" do
    expect(Category.all.to_sql).to eq(Category.reorder('').order(created_at: :asc).to_sql)
  end
end
