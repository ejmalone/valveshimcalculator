# frozen_string_literal: true

module ApplicationHelper
  def form_errors_element(*targets)
    tag.div class: 'form_errors' do
      targets.each do |target|
        concat tag.div class: 'form_error', data: { "#{target}-target" => 'error' }
      end
    end
  end
end
