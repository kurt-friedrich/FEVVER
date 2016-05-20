class InviteMailer < ApplicationMailer
  default from: "fevver@example.com"

  def new_user_invite(invite, url)
    @invite = invite
    @url = url
    mail(to: @invite.email, subject: 'Come join your band on FEVVER')
  end

  def existing_user_invite(invite)
    @invite = invite
    @url = login_url
    mail(to: @invite.email, subject: 'You were added to a band on FEVVER')
  end
end
