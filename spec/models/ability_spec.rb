require "cancan/matchers"

describe 'Ability' do
  let!(:user) { create(:user) }
  let!(:ability) { Ability.new(user) }

  it "admin user permission" do
    %w(Article EmailSubscribe AboutMe BlogSeo Category User Ckeditor::AttachmentFile Ckeditor::Picture).each  do |model_name|
      expect(ability.can?(:manage, model_name.constantize.new)).to be true
    end

    expect(ability.can?(:setting, BlogSetting.new)).to be true
    expect(ability.can?(:access, :rails_admin)).to be true
    expect(ability.can?(:dashboard, nil)).to be true
  end
end
