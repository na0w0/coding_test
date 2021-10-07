module DeviseHelper
  # INFO: deviseのsign_inはflashメッセージが返ってくるが
  #       デフォルトのキーnoticeとalertしか返ってこないのでbootstrapのキーに変換する
  def convert_flash_type(key)
    case key
    when 'alert'
      'warning'
    when 'notice'
      'success'
    else
      key
    end
  end

  def devise_error_messages!
    return '' unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class='alert alert-danger'>
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end
end
