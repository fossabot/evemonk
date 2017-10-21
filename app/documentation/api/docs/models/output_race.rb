# frozen_string_literal: true
module Api
  module Docs
    module Models
      class OutputRace
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputRace do
          key :required, [:description, :race_id, :race_name,
                          :short_description, :icon_id]
          property :description do
            key :type, :string
            key :description, 'Race description'
          end
          property :race_id do
            key :type, :integer
            key :format, :int64
            key :description, 'Race ID'
          end
          property :race_name do
            key :type, :string
            key :description, 'Race name'
          end
          property :short_description do
            key :type, :string
            key :description, 'Race short description'
          end
          property :icon_id do
            key :type, :integer
            key :format, :int64
            key :description, 'Race icon ID'
          end
          key :example, description: 'Once a thriving tribal civilization, the Minmatar...',
                        race_id: 2,
                        race_name: 'Minmatar',
                        short_description: 'Breaking free of Amarrian subjugation...',
                        icon_id: 1440
        end
        # :nocov:
      end
    end
  end
end