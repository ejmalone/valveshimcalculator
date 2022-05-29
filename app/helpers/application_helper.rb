# frozen_string_literal: true

module ApplicationHelper
  def form_errors_element(*targets)
    tag.div class: 'row alert alert-danger d-none' do
      targets.each do |target|
        concat tag.div class: 'form_error', data: { "#{target}-target" => 'error' }
      end
    end
  end

  def centered_content
    tag.div class: "row justify-content-center" do
      tag.div class: "col-md-12 col-lg-8" do
        yield
      end
    end
  end
end
