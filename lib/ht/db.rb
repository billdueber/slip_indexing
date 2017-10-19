module HT
  class DB
    if defined? JRUBY_VERSION
      require 'ht/jruby/db'
      extend HT::JRuby::DB
    else
      require 'ht/mri/db'
      extend HT::MRI::DB
    end

    # self.db is defined in the prepended class for jruby or MRI

    class << self

      def instance(passed_db = nil)
        @db ||= (passed_db || self.db)
      end

      def db_machine
        ENV['HT_DB_MACHINE']
      end

      def db_name
        ENV['HT_DB_NAME']
      end

      def db_user
        ENV['HT_DB_USER']
      end

      def db_password
        ENV['HT_DB_PASSWORD']
      end
    end

  end
end
