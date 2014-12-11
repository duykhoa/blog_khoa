module ParamsExt
  extend ActiveSupport::Concern

  private

    def sanitize_params(arg)
      arg ? arg.to_url : '-'
    end

    def index_params(params)
      params.permit(:page)
    end

    def search_params(search_params = params)
      search_params.permit(:query, :page).tap do |args|
        args[:query] = args[:query].present? ? sanitize_params(args[:query]) : '-'
      end.tap do |args|
        args.delete_if { |k, v| k.eql?('page') && v.eql?(1) }
      end
    end

    def category_params(category_params = params)
      category_params.permit(:category_name, :page, :query).tap do |args|
        args[:category_name] = sanitize_params args[:category_name]
        args[:query] = sanitize_params args[:query]
      end.tap do |args|
        args.delete_if { |k, v| k.eql?('page') && v.eql?(1) }
      end
    end
end
