class Category < ActiveRecord::Base

  scope :position_ordering, -> { all.order(position: :asc) }

  def sanitize_name
    name.parameterize_string
  end

  def self.list
    @@categories ||= all
  end

  def self.update_or_create(category_list)
    delete_category_not_in(category_list.values.map {|category| category[0]})

    category_list.each do |index, category_names|
      category = find_or_initialize_by(name: category_names[0])
      category.name = category_names[1]
      category.position = index
      category.save
    end
  end

  def self.delete_category_not_in(existed_categories)
    where.not(name: existed_categories).delete_all
  end

  rails_admin do
  end
end
