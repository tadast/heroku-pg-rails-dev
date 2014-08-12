require 'yaml'

class Heroku::Command::Pg < Heroku::Command::Base

  # pg:sync
  #
  # replaces contents of local DB with the ones from DATABASE_URL
  #
  def sync
    remote_uri = generate_resolver.resolve("DATABASE_URL").url
    local_uri = "postgres:///#{rails_dev_db}"

    pgdr = PgDumpRestore.new(
      remote_uri,
      local_uri,
      self
    )

    display "Dropping local database..."
    `bundle exec rake db:drop`

    pgdr.execute
  end

private

  def rails_dev_db
    env = ENV['RAILS_ENV'] || ENV['RAKE_ENV'] || 'development'
    YAML.load_file('config/database.yml')[env]['database']
  end
end
