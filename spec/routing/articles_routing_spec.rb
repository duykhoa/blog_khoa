describe "Article Routing" do
  it "routes to index action" do
    expect(get: "/").to route_to(
      controller: "articles",
      action: "index"
    )
  end

  describe "#search action" do
    it "routes to search action" do
      expect(get: "/search/java").to route_to(
        controller: "articles",
        action: "search",
        query: "java"
      )
    end

    it "routes to search action with category" do
      expect(get: "/search/category/java").to route_to(
        controller: "articles",
        action: "search",
        category_name: "java"
      )
    end

    it "routes to search action with category and query" do
      expect(get: "/search/category/java/ruby").to route_to(
        controller: "articles",
        action: "search",
        category_name: "java",
        query: "ruby"
      )
    end
  end
end
