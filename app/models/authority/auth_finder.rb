# This class should be called statically to execute common Solr queries
module Authority
  class AuthFinder

    def self.obj(id)
      ActiveFedora::SolrService.query("id:#{id}")
    end

    def self.all_things(q,model)
      q = q.downcase if q.present?
      qs = q.split(" ") if q.present?
      qs ||= []
      qs.map!{|t| "typeahead_tesim:#{t}"}
      solr_q = qs.join(" && ")
      unless model == 'all'
        ActiveFedora::SolrService.query(solr_q,:fq=>"active_fedora_model_ssi:Authority*#{model}", :sort =>'display_value_ssi asc', :rows => self.max_rows)
      else
        ActiveFedora::SolrService.query(solr_q, :sort =>'display_value_ssi asc', :rows => self.max_rows)
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