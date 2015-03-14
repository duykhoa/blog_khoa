class BlogSetting < ActiveRecord::Base
  DEFAULT_SETTING =
    {
      mailchimp_api_key: '',
      mailchimp_list_id: '',
      blog_title: 'PhuongBui',
      blog_description: 'A Digital Marketing and Branding Stories Blog',
      facebook_image_url: '',
      facebook_description: '',
      email_subscriber_text: 'Please subscribe',
      facebook_app_id: '',
      theme: 'phuongbui',
      url: 'http://duykhoa.tenluaweb.com'
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
