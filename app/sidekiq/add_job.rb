class AddJob
  include Sidekiq::Job

  def perform(int1, int2)
    Adder.create(value: int1 + int2)
  end
end
