
require 'sinatra'
require 'htmlentities'
require 'uri'
require 'mustache'

HTML         = HTMLEntities.new
MEDIA_TITLES = "../media_setup/progs/urls"
HOMEPAGE     = File.read("./Public/homepage/markup.mustache")
media_setup  = File.expand_path(Dir.pwd + "/../media_setup/bin/media_setup")

enable :static
set :public_folder, File.dirname(__FILE__) + "/Public"
disable :show_exceptions

get '/' do
  last_file = nil
  sites = Dir.glob("#{MEDIA_TITLES}/*.txt").sort.inject([]) do | entrys, file |

    last_file = file
    entrys.push(
      File.read(file).split("\n").inject({'filename': file}) do |entry, line|
        line.scan(/^(\w+):\ +([^\n]+)/).each do |(key, raw)|
          if !['info', 'url'].include?(key)
            entry[key] = HTML.encode(raw)
          else
            entry[key] = URI.encode(HTML.encode(raw), /\W/)
            if key == 'url'
              entry['href'] = '/media/?url=' + entry[key]
            end
          end

          entry
        end # === each (key, raw)
        entry
      end # === inject entry
    ) # === File.read

    entrys
  end # === Dir.glob

  Mustache.render(
    HOMEPAGE,
    sites: sites,
    sites_mtime: File.mtime(last_file || MEDIA_TITLES),
    now: Time.now.utc.to_i
  )
end

get '/media/' do
  content_type 'application/m3u'
  "#EXTM3U\n#{params['url']}"
end

error do
  "unexpected error"
end
