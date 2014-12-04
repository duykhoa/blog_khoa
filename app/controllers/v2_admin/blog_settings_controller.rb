class V2Admin::BlogSettingsController < ApplicationController
  layout 'admin'

  def index
  end

  def update
    BlogSetting.bulk_update(blog_setting_params)
  end

  private

  def blog_setting_params
    params
      .require(:blog_setting)
      .permit(
        :blog_title, :blog_description, :facebook_image_url, :fb_description,
        :mailchimp_api_key, :mailchimp_list_id, :email_subscriber_text
      )
  end
end
