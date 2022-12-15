
# frozen_string_literal: true

require 'pagy/extras/bootstrap'
require 'pagy/extras/i18n'
Pagy::I18n.load(locale: 'pt-BR')
Pagy::DEFAULT[:max_per_page] = 10
Pagy::DEFAULT[:items] = 10
Pagy::DEFAULT[:size]  = [1, 4, 4, 1]
