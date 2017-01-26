
require 'sinatra'
require 'htmlentities'
require 'uri'

HTML = HTMLEntities.new
media_setup=File.expand_path(Dir.pwd + "/../media_setup/bin/media_setup")

get '/' do
  final = ""
  txt = File.read "../cache_setup/progs/media-titles.txt"
  txt.split("\n").each do |line|
    pieces = line.split('|')
    name = HTML.encode pieces[0]
    url = HTML.encode pieces[1]
    title = HTML.encode pieces[2]
    final += "<a href=\"/media/?url=#{URI.encode url, /\W/}\">#{name}</a>: #{title}<br>"
  end

  final
end

get '/media/' do
  content_type 'application/m3u'
  "#EXTM3U\n#{params['url']}"
end

error do
  "unexpected error"
end
