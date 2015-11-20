module Authority
  class Person < ActiveFedora::Base
    include ::Authority::Concern::Thing

    property :family_name, predicate: ::RDF::Vocab::SCHEMA.familyName, multiple: false do |index|
                                index.as :stored_searchable
                              end
    property :given_name, predicate: ::RDF::Vocab::SCHEMA.givenName, multiple: false do |index|
                                index.as :stored_searchable
                              end

    property :additional_name, predicate: ::RDF::Vocab::SCHEMA.additionalName, multiple: false  do |index|
                                index.as :stored_searchable
                              end
    property :address, predicate: ::RDF::Vocab::SCHEMA.address, multiple: false
    property :gender, predicate: ::RDF::Vocab::SCHEMA.gender, multiple: false
    property :job_title, predicate: ::RDF::Vocab::SCHEMA.jobTitle, multiple: false
    property :email, predicate: ::RDF::Vocab::SCHEMA.email, multiple: false do |index|
                                index.as :stored_searchable
                              end
    property :birth_date, predicate: ::RDF::Vocab::SCHEMA.birthDate, multiple: false
    property :death_date, predicate: ::RDF::Vocab::SCHEMA.deathDate, multiple: false

  end


  def display_value
    value = (full_name.present?) ? full_name : ''
    value += ', ' if birth_date.present? || death_date.present?
    value += self.display_date if self.display_date.present?
    value
  end

  def full_name
    if family_name.present?
      full = "#{family_name}"
      full += ", #{additional_name}" if additional_name.present?
      full += ", #{given_name}" if given_name.present?
    else
      full = _name
    end
    full
  end

  def display_date
    self.date_range(start_date: birth_date, end_date: death_date)
  end


end
