class AboutMe < ActiveRecord::Base
  has_attached_file(
    :avatar,
    styles:
      { :thumb => "120x120#" },
    default_url: "/images/missing.png")
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  rails_admin do
    label_plural "About me"
    edit do
      field :avatar
      field :short_content
      field :content, :ck_editor
    end
  end
end
