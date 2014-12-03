class UserMailer < ActionMailer::Base
  default from: 'SqdUp <notifications@sqdup.com>'
  
  def new_contact_form_entry(name,email,subject,message)
    @name = name
    @email = email
    @subject = subject
    @message = message
    mail(to: 'sunny@zoraab.com' , subject: "SqdUp: New Contact Form Submimssion").deliver
  end
end