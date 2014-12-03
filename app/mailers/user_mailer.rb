class UserMailer < ActionMailer::Base
  default from: 'SqdUp <notifications@sqdup.com>'
  
  def new_contact_form_entry(email)
    subject = "SqdUp: New Contact Form Submimssion"
    mail(to: email , subject: subject).deliver
  end
end