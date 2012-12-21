module ApplicationHelper
  def error_messages_for(record)
    messages = []
    record.errors.messages.each do |attribute, errors|
      if attribute.to_s =~ /\./
        names = attribute.to_s.split('.')
        class_name = names.first.singularize
        attribute = names.last
      else
        class_name = record.class.to_s.parameterize
        attribute = attribute
      end
      pre_message = record.respond_to?(attribute.to_sym) ? 'Le champ ' : ''
      message = pre_message + t("activerecord.attributes.#{class_name}.#{attribute}") + ' '
      message += errors.first
      messages << message
    end

    content_tag(:ul, :class => 'error_messages') do
      messages.each do |message|
        concat content_tag(:li, message, :class => 'error_message')
      end
    end if messages.present?
  end

  def facebook_like_button(url, options={})
    content_tag(:div, nil, {
      :class => 'fb-like',
      'data-href' => url,
      'data-send' => 'false',
      'data-layout' => 'button_count',
      'data-width' => options[:width] || '105',
      'data-show-faces' => 'false'
    })
  end
end
