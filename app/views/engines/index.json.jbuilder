# frozen_string_literal: true

json.array! @engines, partial: 'engines/engine', as: :engine
