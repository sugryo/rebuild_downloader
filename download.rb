require "rss"

rss = RSS::Parser.parse("http://feeds.rebuild.fm/rebuildfm")

rss.items.each do |item|
  puts item.title
  system("curl",
	 "--location",
	 "--output",
	 "#{item.title}.mp3",
	 "#{item.enclosure.url}")
end
