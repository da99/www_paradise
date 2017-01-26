
require 'sinatra'
require 'htmlentities'
require 'uri'

HTML = HTMLEntities.new
MEDIA_TITLES = "../cache_setup/progs/media-titles.txt"
media_setup=File.expand_path(Dir.pwd + "/../media_setup/bin/media_setup")

get '/' do
  final = ""
  txt = File.read MEDIA_TITLES
  txt.split("\n").each do |line|
    pieces = line.split('|')
    name = HTML.encode pieces[0]
    url = HTML.encode pieces[1]
    title = HTML.encode pieces[2]
    final += "<a href=\"/media/?url=#{URI.encode url, /\W/}\">#{name}</a>: #{title}<br>"
  end

  final += "<br><br>#{File.mtime MEDIA_TITLES}"
  final
end

get '/media/' do
  content_type 'application/m3u'
  "#EXTM3U\n#{params['url']}"
end

error do
  "unexpected error"
end
