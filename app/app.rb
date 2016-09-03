module App
  def self.env
    @env ||= (ENV['SUZY_ENV'] || :development).to_sym
  end

  def self.root
    @root ||= File.absolute_path(File.join(File.dirname(__FILE__), '../'))
  end

  def self.config
    @config ||= App::Config.new
  end

  def self.db
    if ENV['DATABASE_URL']
      @db ||= Sequel.connect(ENV['DATABSE_URL'])
    else
      @db ||= Sequel.postgres(self.config.db_name,
                              user: self.config.db_user,
                              password: self.config.db_password,
                              host: self.config.db_host
      )
    end
  end
end
