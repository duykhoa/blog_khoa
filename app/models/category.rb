class Category < ActiveRecord::Base

  def sanitize_name
    name.parameterize_string
  end

  def self.list
    @@categories ||= all
  end

  rails_admin do
  end
end
