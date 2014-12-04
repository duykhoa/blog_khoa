class BlogSetting < ActiveRecord::Base
  DEFAULT_SETTING =
    {
      mailchimp_api: '8ae750bfd7f6d3d8f7a5c3c45a2a9a2a-us8',
      mailchimp_list: '45c3380fe4',
      fb_app_id: '',
      blog_title: 'Phuong Bui | Marketing Blog',
      blog_description: 'A Marketing Blog (mostly stories)',
      url: 'http://phuongbui.me',
      fb_image: 'http://phuongbui.me/fbog.jpg',
      fb_description: 'Phuong Bui Marketing Blog sample content',
      theme: 'v2_0',
      email_subscriber_text: 'Please subscribe'
    }

  after_save :restart_setting

  validates :key, uniqueness: true

  def self.settings
    @@settings ||= BlogSetting.all.inject({}) { |hash, setting| hash.merge(setting.key => setting.value) }
  end

  class << self
    DEFAULT_SETTING.each do |key, value|
      define_method "#{key}" do
        BlogSetting.settings.fetch(key.to_s) rescue nil
      end
    end
  end

  private

  def restart_setting
    @@settings = nil
  end
end
