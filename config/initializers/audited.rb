# frozen_string_literal: true

require 'audited'

Audited::Railtie.initializers.each(&:run)
