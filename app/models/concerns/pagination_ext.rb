module PaginationExt
  extend ActiveSupport::Concern

  module ClassMethods
    def page_params(params)
      params.key?(:page) ? params.fetch(:page).to_i : 1
    end
  end
end
