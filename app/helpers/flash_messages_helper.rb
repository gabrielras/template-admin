# frozen_string_literal: true

# FlashMessagesHelper
module FlashMessagesHelper
  include RenderHamlHelper

  def flash_message(object = nil)
    messages = { flash: messages_in_flash }
    haml = write_flash_messages(messages[:flash], 10)
    return haml unless object

    messages[:object] = messages_in_object(object)
    haml += write_flash_messages(messages[:object], 20)
    haml.html_safe
  end

  def messages_in_flash
    messages = []
    %i[notice success alert error information].each do |flash_type|
      next if flash[flash_type].blank?

      flash[flash_type].split('<br/>').each do |message|
        error_message = message.split(':').join(':<br/>')
                               .split(',').join('.<br/>')
        error_message += '.'

        messages << [flash_type, error_message]
      end
      flash[flash_type] = nil
    end
    messages
  end

  def messages_in_object(object = nil)
    return [] if object.nil? || object.errors.full_messages.blank?

    messages = []
    object.errors.full_messages.uniq.each do |error|
      messages << [:error, error.to_s]
    end
    messages
  end

  def message_title_by(type)
    message_title_class_by(type)[0]
  end

  def message_class_by(type)
    message_title_class_by(type)[1]
  end

  def message_title_class_by(type)
    case type
    when :success, :notice then ['Informação: ', 'toast-success']
    when :alert, :warning  then ['Atenção: ', 'toast-warning']
    when :error            then ['Erros: ', 'toast-danger']
    when :information      then ['Nota: ', 'toast-info']
    else %w[Mensagem toast-info]
    end
  end

  def write_flash_messages(messages, top)
    return '' if messages.blank?

    type = messages.first.first
    css = message_class_by(type)

    render_haml <<-HAML, messages: messages, type: type, css: css, top: top
      .toast-container.position-absolute.end-0.p-3{style: "top: #{top}%; margin-right: 2.5rem"}
        .fade.toast.show{"aria-atomic" => "true", "aria-live" => "assertive", :role => "alert"}
          .toast-body.d-flex{class: css}
            = svg_icon(css, class: 'm-2 flex-fill')
            - if messages.size == 1
              .toast-message
                = messages.last.last
              .toast-close
                %button.end-0.mb-1.close.btn.btn-sm
                  %span{"aria-hidden" => "true"} ×
            - else
              .toast-message= message_title_by(type)
              .toast-close
                %button.end-0.mb-1.close.btn.btn-sm
                  %span{"aria-hidden" => "true"} ×
              %hr
              - messages.each do |type, message|
                = message
                %br
    HAML
  end
end
