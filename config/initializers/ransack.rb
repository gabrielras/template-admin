# frozen_string_literal: true

Ransack.configure do |config|
  # config.postgres_fields_sort_option = :nulls_first # or :nulls_last
  config.postgres_fields_sort_option = :nulls_last
end
