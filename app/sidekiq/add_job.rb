# frozen_string_literal: true

class AddJob
  include Sidekiq::Job

  def perform(int1, int2)
    Adder.create(value: int1 + int2)
    Rollbar.info 'Done with AddJob', one: int1, two: int2
  end
end
