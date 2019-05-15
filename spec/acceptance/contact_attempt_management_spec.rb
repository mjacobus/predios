# frozen_string_literal: true

require 'acceptance_helper'

RSpec.describe 'contact attempt management', type: :acceptance do
  let(:building) { building_factory.create(number_of_apartments: 2) }
  let(:apartment1) { apartment_factory.create(building: building) }
  let(:apartment2) { apartment_factory.create(building: building) }

  before do
    clear_all
    login_as_master
    apartment1
    apartment2
  end

  specify 'adding a contact attempt' do
    visit("/buildings/#{building.number}/apartments")

    click_element(tag_name: 'span', data_apartment: apartment1.number)
    click_on('Tentar contato')
    byebug
    click_label('Telefone')
    click_button(/Sim/)
    # byebug

    # # default intercom
    page.wait_until do
      page.has_element?(
        tag_name: 'span',
        data_contact_attempt_success: 'true',
        data_contact_attempt_type: 'intercom',
      )
    end
  end
end
