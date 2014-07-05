module ParamsExt
  extend ActiveSupport::Concern

  private

    def sanitize_params(arg)
      arg ? arg.gsub(/\W/, '-') : '-'
    end

    def index_params
      params.permit(:page).tap do |args|
        args[:page] = args[:page].to_i > 0 ? args[:page].to_i : 1
      end
    end

    def search_params
      params.permit(:query, :page).tap do |args|
        args[:query] = args[:query].present? ? sanitize_params(args[:query]) : '-'
        args[:page] = args[:page].to_i > 0 ? args[:page].to_i : 1
      end
    end

    def category_params
      params.permit(:category_name, :page, :query).tap do |args|
        args[:category_name] = sanitize_params args[:category_name]
        args[:query] = sanitize_params args[:query]
        args[:page] = args[:page].to_i > 0 ? args[:page].to_i : 1
      end
    end
end
