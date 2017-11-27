class PostMailer < ActionMailer::Base
  def post_created post
    @post = post
    mail(to: @post.user.email, from: "gordonstormberg@gmail.com", subject: t(".post_created_subject"))
  end
end
