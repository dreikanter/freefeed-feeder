require 'dotenv/tasks'

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] => [:dotenv] do |t, args|
    require 'sequel'
    Sequel.extension :migration, :pg_array, :pg_json

    db = Sequel.connect(ENV.fetch('DATABASE_URL'))

    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, 'db/migrations', target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, 'db/migrations')
    end
  end
end
