# frozen_string_literal: true

json.extract! engine, :id, :num_cylinders, :valves_per_cylinder, :name, :intake_min, :intake_max,
              :exhaust_min, :exhaust_max, :created_at, :updated_at
json.url engine_url(engine, format: :json)
