class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_if_hs_open

  def check_if_hs_open
    @event = Event.light.where('created_at >= ?', 30.minutes.ago).order(created_at: :desc).first

    @hs_open_status = if @event.nil?
                        Hspace::UNKNOWN
                      else
                        event_status
                      end
    # @hs_open_status = Hspace::OPENED
    # для отладки индикатора
  end

  private
  def event_status
    @event.value == 'on' ? Hspace::OPENED : Hspace::CLOSED
  end
end
