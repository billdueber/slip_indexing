module HT
  class Secrets
    def db_machine
      'mysql-sdr'
    end

    def db
      ENV['HT_DB']
    end

    def db_user
      ENV['HT_DB_USER']
    end

    def db_password
      ENV['HT_DB_PASSWORD']
    end
  end
end
