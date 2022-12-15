# frozen_string_literal: true

# Helpers Genericos utilizados para o Layout do sistema
module LayoutsHelper
  DEFAULT_OPTS = { class: 'tabler-icon' }.freeze

  def disabled_radio(id, value)
    radio_button_tag id, true, value, class: 'form-check-input disabled'
  end

  def ransack_link(model, field, order = :asc)
    sort_link(@q, field, model.human_attribute_name(field), default_order: order)
  end

  def svg_icon(icon, opts = {})
    opts = DEFAULT_OPTS if opts.blank?
    inline_svg_tag("svg/#{icon}.svg", opts)
  end
end
