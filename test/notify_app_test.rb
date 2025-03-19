require File.expand_path "../test_helper.rb", __FILE__
require "minitest/autorun"

class MyTest < Minitest::Test
  include Rack::Test::Methods

  def app
    NotifyApp
  end

  def test_get_root
    $ses.expect :send_email, true

    get "/"
    assert last_response.ok?
    assert_equal %[{"ok":true}], last_response.body
  end

  def test_post_root
    $ses.expect :send_email, true

    post "/"
    assert last_response.ok?
    assert_equal %[{"ok":true}], last_response.body
  end

  def test_put_root
    $ses.expect :send_email, true

    put "/"
    assert last_response.ok?
    assert_equal %[{"ok":true}], last_response.body
  end

  def test_patch_root
    $ses.expect :send_email, true

    put "/"
    assert last_response.ok?
    assert_equal %[{"ok":true}], last_response.body
  end

  def test_delete_root
    $ses.expect :send_email, true

    delete "/"
    assert last_response.ok?
    assert_equal %[{"ok":true}], last_response.body
  end

  def test_body_params
    delete "/"
    assert last_response.ok?
    assert_match "REQUEST_METHOD => DELETE", $ses.body
  end

  def test_url_info
    get "/abc/def"
    assert last_response.ok?
    assert_match "abc/def", $ses.body
  end

  def test_url_params
    get "/abc/def?ghi=jkl"
    assert last_response.ok?
    assert_match (/ghi.*jkl/), $ses.body
  end

  def test_post_params
    post "/abc/def", ghi: :jkl
    assert last_response.ok?
    assert_match (/ghi.*jkl/), $ses.body
  end

  def test_subject
    post "/abc/def"
    assert last_response.ok?
    assert_equal "[NotifyApp]", $ses.subject
  end

  def test_subject_from_get
    get "/abc/def?subject=MyApp"
    assert last_response.ok?
    assert_equal "MyApp", $ses.subject
  end

  def test_subject_from_post
    post "/abc/def", subject: "MyPostApp"
    assert last_response.ok?
    assert_equal "MyPostApp", $ses.subject
  end
end
