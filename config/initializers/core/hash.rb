class Hash
  # --------------------------------------------------------------
  # Allows merging new stimulus controllers & actions to an existing `data` hash
  def merge_stimulus_data(new_data)
    new_data.each do |key, value|
      if %i[ controller action ].include?(key)
        self[key] = "#{ self[key] } #{ value }"
      else
        self[key] = value
      end
    end

    self
  end
end