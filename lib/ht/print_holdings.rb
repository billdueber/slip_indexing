require 'ht/db'

module HT

  class PrintHoldings

    PHDB_Query = HT::DB.instance[:holdings_htitem_htmember].select(:volume_id, :member_id).where(volume_id: :$vol_ids)

    def initialize(passed_seeds = [])
      seeds = Array(passed_seeds)
      @htid_map = {}
      self.seed(seeds) unless seeds.empty?
    end

    def seed(htid_seeds)
      if @htid_map.size > 1000
        @htid_map = {}
      end
      PHDB_Query.call(:select, volume_ids: Array(htid_seeds)).each do |r|
        @htid_map[r[:volume_id]] << r[:member_id]
      end
    end

    def [](htid)
      seed(htid) unless @htid_map[htid]
      @htid_map[htid]
    end

  end
end


