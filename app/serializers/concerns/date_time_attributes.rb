# frozen_string_literal: true

# this module provides easy way to set up date time attributes, converted to timestamps
module DateTimeAttributes
  extend ActiveSupport::Concern

  class_methods do
    def date_time_attributes(*attrs)
      attributes(*attrs)

      attrs.each do |attr|
        define_method attr do
          object.public_send(attr)&.to_i
        end
      end
    end
  end
end
