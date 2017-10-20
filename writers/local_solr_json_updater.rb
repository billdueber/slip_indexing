require 'traject'
require 'traject/solr_json_writer'

settings do
  provide "solr.url", ENV["SOLR_URL"]
  provide "solr_writer.commit_on_close", "true"
  provide "solr_writer.thread_pool", 2
  provide "solr_writer.batch_size", 10
  provide "writer_class_name", "Traject::SolrJsonWriter"
  provide "processing_thread_pool", 5
  provide "log.batch_size", 1_000
end
