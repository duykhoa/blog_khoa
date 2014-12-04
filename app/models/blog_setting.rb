class BlogSetting < ActiveRecord::Base
  DEFAULT_SETTING =
    {
      mailchimp_api_key: '8ae750bfd7f6d3d8f7a5c3c45a2a9a2a-us8',
      mailchimp_list_id: '45c3380fe4',
      blog_title: 'Phuong Bui | Marketing Blog',
      blog_description: 'A Marketing Blog (mostly stories)',
      facebook_image_url: 'http://phuongbui.me/fbog.jpg',
      facebook_description: 'Phuong Bui Marketing Blog sample content',
      email_subscriber_text: 'Please subscribe',
      theme: 'v2_0',
      url: 'http://phuongbui.me'
    }

  after_save :restart_setting

  validates :key, uniqueness: true

  def self.settings
    @@settings ||= BlogSetting.all.inject({}) { |hash, setting| hash.merge(setting.key => setting.value) }
  end

  class << self
    DEFAULT_SETTING.each do |key, value|
      define_method "#{key}" do
        settings.fetch(key.to_s) rescue nil
      end

      define_method "#{key}=" do |new_value|
        find_by_key(key)
        .update_attributes(value: new_value)
      end
    end

    def bulk_update(settings_params)
      settings_params.each do |key, value|
        send("#{key}=", value)
      end
    end
  end

  private

  def restart_setting
    @@settings = nil
  end
end
