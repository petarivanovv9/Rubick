module HaltHelper
  def halt_with_message(status, message)
    halt(
      status,
      erb(:'errors/404', :locals => {:error_message => "#{message}"})
      )
  end
end
