require File.expand_path "../test_helper.rb", __FILE__
require "minitest/autorun"

class MyTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    NotifyApp
  end

  def setup
    Mail::TestMailer.deliveries.clear
  end

  def test_get_root
    get "/"
    assert last_response.ok?
    assert_equal "Ok", last_response.body
    assert_equal 1, Mail::TestMailer.deliveries.length
  end

  def test_post_root
    post "/"
    assert last_response.ok?
    assert_equal "Ok", last_response.body
    assert_equal 1, Mail::TestMailer.deliveries.length
  end

  def test_put_root
    put "/"
    assert last_response.ok?
    assert_equal "Ok", last_response.body
    assert_equal 1, Mail::TestMailer.deliveries.length
  end

  def test_patch_root
    put "/"
    assert last_response.ok?
    assert_equal "Ok", last_response.body
    assert_equal 1, Mail::TestMailer.deliveries.length
  end

  def test_delete_root
    delete "/"
    assert last_response.ok?
    assert_equal "Ok", last_response.body
    assert_equal 1, Mail::TestMailer.deliveries.length
  end

  def test_body_params
    delete "/"
    assert last_response.ok?
    assert_match "REQUEST_METHOD => DELETE", Mail::TestMailer.deliveries.first.body.to_s
  end

  def test_url_info
    get "/abc/def"
    assert last_response.ok?
    assert_match "abc/def", Mail::TestMailer.deliveries.first.body.to_s
  end

  def test_url_params
    get "/abc/def?ghi=jkl"
    assert last_response.ok?
    assert_match (/ghi.*jkl/), Mail::TestMailer.deliveries.first.body.to_s
  end

  def test_post_params
    post "/abc/def", ghi: :jkl
    assert last_response.ok?
    assert_match (/ghi.*jkl/), Mail::TestMailer.deliveries.first.body.to_s
  end

  def test_subject
    post "/abc/def"
    assert last_response.ok?
    assert_equal "[NotifyApp]", Mail::TestMailer.deliveries.first.subject
  end

  def test_subject_from_get
    get "/abc/def?subject=MyApp"
    assert last_response.ok?
    assert_equal "MyApp", Mail::TestMailer.deliveries.first.subject
  end

  def test_subject_from_post
    post "/abc/def", subject: "MyPostApp"
    assert last_response.ok?
    assert_equal "MyPostApp", Mail::TestMailer.deliveries.first.subject
  end
end
