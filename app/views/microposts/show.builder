xml.instruct! :xml, version: '1.0'
xml.rss('version' => '2.0', 'xmlns:dc' => 'http://purl.org/dc/elements/1.1/') do
  xml.channel do
    xml.title "User's Microposts"

    @microposts.each do |micropost|
      xml.item do
        xml.title micropost.content
        xml.description User.find(micropost.user_id).name
        xml.pubDate micropost.created_at
        xml.guid "https://swamp09-sample-app.herokuapp.com/users/#{micropost.user_id}"
        xml.link "https://swamp09-sample-app.herokuapp.com/users/#{micropost.user_id}"
      end
    end
  end
end
