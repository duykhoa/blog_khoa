class Category < ActiveRecord::Base

  def sanitize_name
    name.parameterize_string
  end

  rails_admin do
  end
end
