require "rss"

class Rebuild
  def initialize
    @rss = RSS::Parser.parse("http://feeds.rebuild.fm/rebuildfm")
    @home = Dir.home
  end

  def download
    puts "------ Start downloading ------"
    @rss.items.each do |item|
      puts "Now download -> #{item.title}"
      system("cd",
	     "#{download_directory}")
      system("curl",
	     "--location",
	     "--output",
	     "#{item.title}.mp3",
	     "#{item.enclosure.url}")
    end
    puts "****** Finished downloading ******"
  end

  private
  def download_directory
    "#{@home}/rebuild"
  end

  def create_directory
    begin
      Dir.chdir(download_directory)
    rescue Errno::ENOENT
      Dir.mkdir(download_directory)
    end
  end
end

rebuild = Rebuild.new
rebuild.download
