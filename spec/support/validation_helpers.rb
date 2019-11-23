# frozen_string_literal: true

module ValidationHelpers
  def it_validates_presence_of(*fields)
    fields.each do |field|
      specify { is_expected.to validate_presence_of(field) }
    end
  end
end
