class Category < ActiveRecord::Base
  default_scope lambda { order(created_at: :asc) }

  validates :position, numericality: { only_integer:true }
  validates_uniqueness_of :position

  def sanitize_name
    name.parameterize_string
  end

  def self.all_category_name
    pluck(:name)
      .map { |category| [category, category.parameterize_string] }
  end
end
