# frozen_string_literal: true

module ApplicationHelper
  def form_errors_element(*targets)
    tag.div class: 'alert alert-danger d-none' do
      targets.each do |target|
        concat tag.div class: 'form_error', data: { "#{target}-target" => 'error' }
      end
    end
  end

  def centered_content(&block)
    tag.div class: 'row justify-content-center' do
      tag.div class: 'col-md-12 col-lg-8', &block
    end
  end
end
