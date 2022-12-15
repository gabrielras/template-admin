# frozen_string_literal: true

# Doc
class CnpjValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if value.nil? || value.blank?

    record.send("#{attribute}=", value.tr('^0-9', ''))
    return true if CNPJ.valid?(value)

    record.errors.add(attribute, I18n.t('models.concerns.errors.cnpj_is_invalid'))
  end
end
