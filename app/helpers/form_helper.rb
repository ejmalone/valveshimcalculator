# frozen_string_literal: true

module FormHelper
  def html_options(options, disabled: false)
    options.merge!(disabled: true) if disabled
    options
  end
end