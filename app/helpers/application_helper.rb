module ApplicationHelper
  def alert_class(type)
    case type
    when 'notice'
      'success'
    when 'error'
      'danger'
    when 'info'
      'info'
    when 'alert'
      'warning'
    else
      'info'
    end
  end
end
