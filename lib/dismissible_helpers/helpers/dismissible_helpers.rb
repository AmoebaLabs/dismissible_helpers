module DismissibleHelpers::Helpers::DismissibleHelpers
  def render_dismissible_helper(name)
    unless has_been_dismissed?(name)
      content_tag :div, :class => 'dismissible', :data => { :dismissible_name => name } do
        html = t(name)
        html << "\n"
        html << content_tag(:a, 'Close', :class => 'close', :href => '#')
      end
    end
  end

  private

  def has_been_dismissed?(name)
    if respond_to?(:current_account) && current_account && current_account.respond_to?(:dismissed_helpers)
      dismissed_helpers = current_account.dismissed_helpers
    else
      if cookies[:dismissed_helpers].present?
        dismissed_helpers = YAML.load cookies[:dismissed_helpers]
      else
        dismissed_helpers = []
      end
    end
    dismissed_helpers.include? name
  end
end