module Authority
  module Concerns
    module ModalLayout
      extend ActiveSupport::Concern
      included do

        private

        def set_layout
          logger.debug("setting layout #{self.class}")
          self.class.layout = 'modal' if params['modal'].present?
        end
      end
    end
  end
end