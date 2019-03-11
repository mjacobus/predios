# frozen_string_literal: true

require 'validators/base'

module Buildings
  module CommandValidators
    class CreateBuildingValidator < Validators::Base
      def initialize(repository:)
        @repository = repository
      end

      private

      def perform_validation(command, errors)
        attributes = command.building_attributes

        if attributes[:number].to_s.empty?
          errors.add('Não pode ficar em branco', field: :number)
        elsif @repository.find_by_number(attributes[:number])
          errors.add('Já está sendo usado', field: :number)
        end

        if attributes[:address].to_s.empty?
          errors.add('Não pode ficar em branco', field: :address)
        end
      end
    end
  end
end
