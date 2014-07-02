require "cancan/matchers"

describe 'Ability' do
  let!(:user) { create(:user) }
  let!(:ability) { Ability.new(user) }

  it "admin user permission" do
    expect(ability.can?(:manage, Article.new)).to be true
  end
end
