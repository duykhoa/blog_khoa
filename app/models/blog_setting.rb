class BlogSetting < ActiveRecord::Base
  DEFAULT_SETTING =
    {
      mailchimp_api: '8ae750bfd7f6d3d8f7a5c3c45a2a9a2a-us8',
      mailchimp_list: '45c3380fe4',
      ga_id: '',
      fb_app_id: ''
    }

  after_save :restart_setting

  def self.settings
    @@settings ||= BlogSetting.all.inject({}) { |hash, setting| hash.merge(setting.key => setting.value) }
  end

  class << self
    DEFAULT_SETTING.each do |key, value|
      define_method "#{key}" do
        BlogSetting.settings.fetch(key.to_s)
      end
    end
  end

  private

  def restart_setting
    @@settings = nil
  end
end
