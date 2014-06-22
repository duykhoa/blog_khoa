class AboutMe < ActiveRecord::Base
  rails_admin do
    label_plural "About me"
    edit do
      field :content, :ck_editor
    end
  end
end
