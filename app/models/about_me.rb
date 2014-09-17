class AboutMe < ActiveRecord::Base
  has_attached_file(
    :avatar,
    styles:
      { :w70 => "70x70>" },
    default_url: "/images/missing.png")

  rails_admin do
    label_plural "About me"
    edit do
      field :avatar
      field :content, :ck_editor
    end
  end
end
