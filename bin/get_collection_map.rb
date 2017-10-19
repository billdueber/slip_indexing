require 'yaml'
require 'ht/db'

db = HT::DB.instance

sql = 'select collection, coalesce(mapto_name,name) name from ht_institutions i join ht_collections c on c.original_from_inst_id = i.inst_id'

ccof = {}
db[sql].order(:collection).each do |h|
  ccof[h[:collection].downcase] = h[:name]
end

tmap_dir = File.expand_path(File.join("..", 'lib', 'translation_maps'), __dir__)
File.open(File.join(tmap_dir, 'collection_code_to_original_from.yaml'), 'w:utf-8') {|f| f.puts ccof.to_yaml}

