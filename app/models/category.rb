class Category < ActiveRecord::Base
  default_scope lambda { order(created_at: :asc) }
end
