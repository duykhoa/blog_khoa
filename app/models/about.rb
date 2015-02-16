class About < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :origin => "200x200>"}, :default_url => "missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
