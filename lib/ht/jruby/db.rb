require 'sequel'
require 'ht/db'

module HT
  module JRuby
    module DB

      # Note that sequel is thread-safe in its connection pools, so we don't need to worry about
      # setting it to be thread-local
      #
      # The db methods (db_machine, etc.) are coming from

      def self.db
        Sequel.connect("jdbc:mysql://#{HT::DB.db_machine}/#{HT::DB.db_name}?user=#{HT::DB.db_user}&password=#{HT::DB.db_password}")
      end

    end
  end
end
