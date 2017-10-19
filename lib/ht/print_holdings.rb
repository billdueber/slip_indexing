require 'ht/db'

module HT

  class PrintHoldings

    PHDB_Query = HT::DB.instance[:holdings_htitem_htmember]
                   .select(:volume_id, :member_id)


    def initialize(passed_seeds = [])
      seeds     = Array(passed_seeds)
      @htid_map = self.empty_map
      seed(seeds) unless seeds.empty?
    end

    def empty_map
      Hash.new {|h, k| h[k] = []}
    end

    def seed(htid_seeds)
      if @htid_map.size > 1000
        @htid_map = empty_map
      end
      PHDB_Query.where(volume_id: Array(htid_seeds)).each do |r|
        @htid_map[r[:volume_id]] << r[:member_id]
      end
    end

    def [](htid)
<<<<<<< HEAD
      seed(htid) if @htid_map[htid].empty?
=======
      seed(htid) unless !@htid_map[htid].empty
>>>>>>> b64ecca7a4d96da59282b4d41c12b58bce6b83e9
      @htid_map[htid]
    end

  end
end


