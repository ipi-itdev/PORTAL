class UserMailer < ApplicationMailer

	default from: 'no-reply@IPIsupport.com'
 
  def welcome_email(referral, sendto)
    @referral = referral
    @sendto = sendto	

    @url  = 'http://example.com/login'
    mail(to: "vcr@ipiphil.com",cc: "jib@ipiphil.com", bcc: "ndg@ipiphil.com", subject: "IPI Employee Referral")
    #mail(to: "ndg@ipiphil.com",cc: "ndg@ipiphil.com", bcc: "finding.ned222705@gmail.com", subject: "IPI Employee Referral")
  end

end
