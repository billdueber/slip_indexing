require 'traject/ndj_reader'
require 'queue'
require 'ht/item/catalog_metadata'

module Traject
  module HT
    class FileOfIDsReader < Traject::NDJReader
      include Enumerable

      def initialize(*args, batch_size: 50)
        super
        @queue                    = Queue.new
        @catalog_fetch_group_size = batch_size
        @queue_minimum_size       = batch_size / 10
      end

      def each
        return enum_for(:each) unless block_given?
        cml = nil

        while rawids = @input_stream.take(@catalog_fetch_group_size) do
          ids = clean_up_ids(rawids)
          cml = cm_lookup_for(ids) if cm_needs_refill

          ids.each_with_index do |id, index|
            begin
              yield HT::Item.new(id, catalog_metadata_lookup: cml)
            rescue => e
              logger.error "Problem with id #{id}: #{e}"
              # push it back into another queue somewhere?
              next
            end
          end
        end
      end

      def cm_needs_refill
        @queue.size <= @queue_minimum_size
      end

      def cm_lookup_for(ids)
        HT::Item::CatalogMetadata.new(seeds: ids)
      end

      def clean_up_ids(rawids)
        rawids.map(&:chomp).map(&:strip).reject(&:empty?))
      end

    end
  end
end
