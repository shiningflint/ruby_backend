namespace :db do
  require 'sequel'
  Sequel.extension :migration
  DB = Sequel.connect('postgres://postgres@localhost/playground')

  desc 'Prints current schema version'
  task :version do
    version = get_file_version()
    puts "Schema version: #{version}"
  end

  desc 'Perform migration up to latest migration available'
  task :migrate do
    Sequel::Migrator.run(DB, 'migrations')
    Rake::Task['db:version'].execute
  end

  desc "Perform rollback to specified target or full rollback as default"
  task :rollback, :target do |t, args|
    version = get_file_version(-2)
    version = if args[:target]
                args[:target]
              else
                get_file_version(-2)
              end

    Sequel::Migrator.run(DB, 'migrations', target: version)
    Rake::Task['db:version'].execute
  end

  desc "Perform migration reset (full rollback and migration)"
  task :reset do
    Sequel::Migrator.run(DB, "migrations", target: 0)
    Sequel::Migrator.run(DB, "migrations")
    Rake::Task['db:version'].execute
  end

  def get_file_version(reverse_index = -1)
    if DB.tables.include?(:schema_migrations) &&
       DB[:schema_migrations].all.length > 0 &&
       DB[:schema_migrations].all[reverse_index]
        filename = DB[:schema_migrations].all[reverse_index][:filename]
        /^\d+(?=_)/.match(filename).to_s.to_i
    else
      0
    end
  end
end
