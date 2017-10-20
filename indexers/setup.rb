$:.unshift File.absolute_path File.join(__dir__, '..', 'lib')



# Utility functions
#
# A simple way to construct a lambda that pulls the right thing out of
# the catalog record and sticks it in the accumulator
#
# Man. Really should rewrite traject to not have so many damn side effects!

def catalog_metadata_extractor(catfield, catalog_fieldname_map)
  ->(item, acc) do
    key = catalog_fieldname_map[catfield]
    acc << item.catalog_metadata[key]
  end
end
