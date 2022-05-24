# frozen_string_literal: true

require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @engine = build(:klr650, userable: @anonymous_user, nickname: 'anonymous engine')
    @email = Faker::Internet.email
  end

  test 'anonymous user can create an engine then sign up' do
    assert AnonymousUser.all.blank?
    assert Engine.all.blank?

    get new_engine_url
    assert_response :success
    assert_select "a[href*='users/restart']"

    post engines_url,
         params: { engine: { num_cylinders: @engine.num_cylinders, exhaust_max: @engine.exhaust_max,
                             exhaust_min: @engine.exhaust_min, intake_max: @engine.intake_max,
                             intake_min: @engine.intake_min, make: @engine.make, model: @engine.model,
                             nickname: @engine.nickname, valves_per_cylinder: @engine.valves_per_cylinder } }

    @engine = Engine.where(make: @engine.make, model: @engine.model, nickname: @engine.nickname).last
    anonymous_user = AnonymousUser.last
    assert_equal @engine, anonymous_user.engines.last

    assert_redirected_to edit_all_engine_shims_url(@engine)

    get sign_up_to_save_url
    assert_redirected_to new_user_registration_url

    post '/users', params: { user: { email: @email, password: 'password', password_confirmation: 'password' } }
    assert_redirected_to associate_new_user_url
    get associate_new_user_url
    assert_redirected_to root_url

    user = User.last
    assert_equal @email, user.email
    assert_equal user.anonymous_user, anonymous_user
    assert_equal user.engines.last, @engine
  end
end
