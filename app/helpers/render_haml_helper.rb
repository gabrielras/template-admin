# frozen_string_literal: true

# RenderHamlHelper
module RenderHamlHelper
  def render_haml(haml, locals = {})
    Haml::Engine.new(haml.strip_heredoc, format: :html5).render(self, locals)
  end
end
