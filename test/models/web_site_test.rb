require "test_helper"

class WebSiteTest < ActiveSupport::TestCase
  test "web_site_count" do
    assert_equal 2, WebSite.count
  end
  test "find" do
    assert_equal "Ruby on Rails", web_sites(:rubyonrails).name
  end
end
