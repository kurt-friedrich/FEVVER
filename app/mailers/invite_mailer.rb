class InviteMailer < ApplicationMailer

  def new_user_invite(invite, url)
    @invite = invite
    @url = url
    mail(to: @invite.email, subject: 'join my band pls')
  end

  def existing_user_invite(invite)
    @user = invite.recipient
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'you were added to a band')
  end
end
