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

     def update
       respond_to do |format|
         if @person.update(person_params)
           format.html { redirect_to @person }
         else
           format.html { render :new }
         end
       end
     end

     def new
       @person = Person.new
     end

     def create
       @person = Person.new(person_params)

       respond_to do |format|
         if @person.save
           format.html { redirect_to @person }
         else
           format.html { render :new }
         end
       end
     end

     def destroy
       @person.destroy
       respond_to do |format|
         format.html { redirect_to people_url }
       end
     end

     private

     def set_person
       @person = ActiveFedora::Base.where(id: URI.unescape(params[:id])).first
     end

     def person_params
       params.require(:person).permit( :_name, :description,
                                       :given_name, :family_name, :additional_name,
                                       :birth_date, :death_date,
                                       :address, :gender, :job_title, email: [],
                                       same_as_uri:[])
     end
   end
end
