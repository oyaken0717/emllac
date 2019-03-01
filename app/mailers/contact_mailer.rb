class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: "#{contact.user.email}",
    subject: "pictureの投稿の確認メール"
  end
end
