class Article < ActiveRecord::Base
  has_attached_file(
    :feature_image,
    styles:
      { :medium => "450x450>", :thumb => "100x100>" },
    default_url: "/images/:style/missing.png")

  validates_attachment_content_type :feature_image, :content_type => /\Aimage\/.*\Z/

  default_scope lambda { order(created_at: :desc) }
end
