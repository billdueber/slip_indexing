require 'traject'

# The indexer relies on a reader that delivers as the record an
# HT::Item object, complete with a `HT::CatalogMetadata` object
# which will presumably be pre-seeded with the right ids.

# All the real setup should be done in setup.rb, including
# things like settings, URLs if need be, etc.


# Who are we?
logger.info RUBY_DESCRIPTION

# Let's get some tmaps.

# submitter_from_cc = Traject::TranslationMap.new('ht/collection_code_to_original_from')
CATALOG_FIELDNAME_MAP = Traject::TranslationMap.new('ht/simple_catalog_metadata_mapping')


# Build a `to_field` for each of the simple mappings
CATALOG_FIELDNAME_MAP.hash.each do |catalog_field, slip_field|
  to_field slip_field, catalog_metadata_extractor(catalog_field, CATALOG_FIELDNAME_MAP)
end


