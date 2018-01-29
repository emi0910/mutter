require 'slack/incoming/webhooks'

class SlackNotifier
  def initialize(url, options = {})
    @client = Slack::Incoming::Webhooks.new(url, options)
  end

  def post_article(article, paths = {})
    p article.user.nickname
    message = "New Article was posted in Mutter!!"

    attachment = {
      title: article.title,
      title_link: paths[:article],
      author_name: "By " + article.user.display_name,
      author_link: paths[:user],
      text: (c = article.content).length >= 40 ? c.slice(0..40) + "..." : c,
      color: "good",
      footer: "Mutter",
      ts: article.created_at.to_i,
    }

    @client.post message, attachments: [attachment]
  end
end
