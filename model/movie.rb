require 'kconv'
require 'sequel'

Sequel::Model.plugin :schema
Sequel.connect 'sqlite://db/movies.db'

class Movie < Sequel::Model
  class << self
    def setup 
      set_schema do
        primary_key :id
        string :title
        string :theater
        string :url
        string :start
        string :end
        timestamp :date
      end
    end

    def reset
      drop_table
      setup
      create_table
    end

    def startheaters
      filter(:theater => %w[[シネマQ] [サザンプレックス] [ミハマ7プレックス] [シネマパレット]]).group(:title)
    end

    def sakurazaka
      filter(:theater => '[桜坂劇場]').group(:title)
    end

    def showtime(id)
      filter do |movie|
        movie.title = self[id].title
        movie.start > Time.now.strftime('%H:%m')
      end
    end
  end

  unless table_exists?
    setup
    create_table
  end
end
