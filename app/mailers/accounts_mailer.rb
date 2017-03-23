class AccountsMailer < ApplicationMailer
  def service(account)
    mail(to: account.email, subject: "You are on watch for dailies")
  end

  def remaining(account)
    mail(to: account.email, subject: "You have dailies still remaining!")
  end
end
