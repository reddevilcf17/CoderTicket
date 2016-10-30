module ApplicationHelper
  def bootstrap_class_for flash_type    
    clazz = { success: 'alert-success', error: 'alert-danger', notice: 'alert-warning', alert: 'alert-warning'}[flash_type.to_sym]
    if clazz.to_s.eql? ''
      clazz = 'alert-warning'
    end 

    return clazz
  end

  def flash_messages(opts = {})
    flash.map do |msg_type, message|
      content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
        content_tag(:button, 'x'.html_safe, class: 'close', data: {dismiss: 'alert'}) + message
      end
    end.join.html_safe
  end
end
