class Category < ActiveRecord::Base

  scope :position_ordering, -> { all.order(position: :asc) }

  def sanitize_name
    name.parameterize_string
  end

  def self.list
    @@categories ||= all
  end

  def self.update_or_create(category_list)
    category_list.each do |index, category_names|
      category = find_or_initialize_by(name: category_names[0])
      category.name = category_names[1]
      category.position = index
      category.save
    end
  end

  rails_admin do
  end
end
