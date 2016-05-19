class InviteMailer < ApplicationMailer
  default from: "fevver@example.com"

  def new_user_invite(invite, url)
    @invite = invite
    @url = "https://salty-tundra-17115.herokuapp.com/" + url
    mail(to: @invite.email, subject: 'Come join your band at FEVVER')
  end

  def existing_user_invite(invite)
    @user = invite.recipient
    @url = "https://salty-tundra-17115.herokuapp.com/"
    mail(to: @user.email, subject: 'you were added to a band')
  end
end
