module Authority
   class PeopleController < ApplicationController
     before_action :set_person, only: [:show, :edit, :update, :destroy]

     def index
       @people = Authority::Person.all
     end

     def show
     end

     def edit
     end

     private

     def set_person
       @person = ActiveFedora::Base.where(id: URI.unescape(params[:id])).first
     end
   end
end
