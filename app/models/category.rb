class Category < ActiveRecord::Base
  default_scope lambda { order(created_at: :asc) }

  def sanitize_name
    name.parameterize_string
  end

  def self.all_category_name
    pluck(:name)
      .map { |category| [category, category.parameterize_string] }
  end
end
