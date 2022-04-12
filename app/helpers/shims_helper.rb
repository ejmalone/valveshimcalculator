# frozen_string_literal: true

module ShimsHelper
  def shim_data_controller
    { controller: 'shim', action: 'shim#validate', shim_min_value: Shim::SIZE_LIMITS.first,
      shim_max_value: Shim::SIZE_LIMITS.last }
  end
end
