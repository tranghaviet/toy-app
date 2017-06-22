require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  # test "should get root" do
  #   get static_pages_root_url
  #   assert_response :success
  #   assert_select "title", "Home | Rails"
  # end

  test "should get home" do
    get home_path
    assert_response :success
    assert_select "title", "Home | Rails"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Rails"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Rails"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Rails"
  end

end
