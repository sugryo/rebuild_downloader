require "rss"

class Rebuild
  def initialize
    @rss = RSS::Parser.parse("http://feeds.rebuild.fm/rebuildfm")
  end

  def download
    puts "------ Start downloading ------"
    @rss.items.each do |item|
      puts "Now download -> #{item.title}"
      system("curl",
	     "--location",
	     "--output",
	     "#{item.title}.mp3",
	     "#{item.enclosure.url}")
    end
    puts "****** Finished downloading ******"
  end
end
