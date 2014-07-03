require 'rails_helper'

describe EmailSubscribe, :type => :model do
  it { should allow_value('email@blog.com').for(:email) }
  it { should_not allow_value('emailblog.com').for(:email) }

  describe "#subscribe" do
    let(:email_subscribe) { build(:email_subscribe) }

    it "call #subscribes after create" do
      expect(email_subscribe).to receive(:subscribe).once

      email_subscribe.save!
    end
  end
end
