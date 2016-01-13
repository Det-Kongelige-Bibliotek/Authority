# This class should be called statically to execute common Solr queries
module Authority
  class Finder

    def self.obj(id)
      ActiveFedora::SolrService.query("id:#{id}")
    end

    def self.all_things(q,model)
      solr_q = "typeahead_tesim:#{q}*"
      unless model == 'all'
        ActiveFedora::SolrService.query(solr_q,:fq=>"active_fedora_model_ssi:Authority*#{model}", :sort =>'display_value_ssi asc')
      else
        ActiveFedora::SolrService.query(solr_q, :sort =>'display_value_ssi asc')
      end
    end

    def self.model_query(model)
      "active_fedora_model_ssi: #{model}"
    end

    def self.max_rows
      1000000
    end
  end
end