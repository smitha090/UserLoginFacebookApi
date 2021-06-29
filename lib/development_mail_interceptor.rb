class DevelopmentMailInterceptor
    def self.delivering_email(message)
      message.subject = "#{message.to} #{message.subject}"
      message.to = "smita.patil859@gmail.com"
    end
  end