module Authority
   class PeopleController < ApplicationController
     def index
        render plain: 'Hello'
	response.body # => "Hello from people controller"
	response.content_type # => "text/plain"
     end
   end
end
