#! /usr/bin/env ruby

require "rss"

class Rebuild
  def initialize
    begin
      @rss = RSS::Parser.parse("http://feeds.rebuild.fm/rebuildfm")
    rescue SocketError
      puts "Can't connect Internet"
    end
    @home = Dir.home
  end

  def download
    create_directory
    puts "------ Start downloading ------"
    @rss.items.each do |item|
      Dir.chdir(download_directory) do
	next if File.exist?("#{item.title}.mp3")
	puts "Now download -> #{item.title}"
	system("curl",
	       "--location",
	       "--output",
	       "#{item.title}.mp3",
	       "#{item.enclosure.url}")
      end
    end
    puts "****** Finished downloading ******"
  end

  private
  def download_directory
    File.join(@home, "rebuild")
  end

  def create_directory
    Dir.mkdir(download_directory) unless Dir.exist?(download_directory)
  end
end

rebuild = Rebuild.new
rebuild.download
