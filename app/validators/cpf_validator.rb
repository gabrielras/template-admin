# frozen_string_literal: true

# Doc
class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if value.nil? || value.blank?

    record.send("#{attribute}=", value.tr('^0-9', ''))
    return true if CPF.valid?(value)

    record.errors.add(attribute, I18n.t('models.concerns.errors.cpf_is_invalid'))
  end
end
