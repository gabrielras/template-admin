# frozen_string_literal: true

class FilesAttachedValidator < ActiveModel::EachValidator
  def validate_each(_record, _attribute, value)
    return unless value.attached?

    # value.blobs.each do |blob|
    #  if blob.byte_size > 10_000_000
    #    value.purge
    #    record.errors.add(attribute, 'Muito longo, deve ser inferior a 10 megabytes.')
    #  elsif ['image/png', 'image/jpg', 'application/pdf'].exclude? blob.content_type
    #    value.purge
    #    record.errors.add(attribute, 'Formato errado, deve ser no formato pdf, jpg ou png.')
    #  end
    # end
  end
end
