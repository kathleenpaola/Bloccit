class FavoriteMailer < ActionMailer::Base
  default from: "kathleen.paola@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    headers["Message-ID"] = "<comments/#{@comment.id}@kathleenpaolabloccit.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{@post.id}@kathleenpaolabloccit.herokuapp.com>"
    headers["References"] = "<post/#{@post.id}@kathleenpaolabloccit.herokuapp.com>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
