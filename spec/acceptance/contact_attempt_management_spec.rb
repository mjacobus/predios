# frozen_string_literal: true

require 'acceptance_helper'

RSpec.describe 'contact attempt management', type: :acceptance do
  let(:building) { building_factory.create(number_of_apartments: 2) }
  let(:apartment) do
    apartment_factory.create_with_aggregate(building_id: building.uuid)
  end

  before do
    clear_all

    login_as_master
    apartment
  end

  specify 'adding a contact attempt' do
    visit("/buildings/#{building.number}/apartments")

    # default with custom date
    click_element(tag_name: 'span', data_apartment: apartment.number)
    click_on('Tentar contato')
    fill_in('when', with: '2019/12/31 18:32')
    click_button('Sim')

    expect(page).to have_element(
      tag_name: 'span',
      data_contact_attempt_success: 'true',
      data_contact_attempt_type: 'intercom',
      text: '31/12/2019 18:32'
    )

    # default intercom
    click_element(tag_name: 'span', data_apartment: apartment.number)
    click_on('Tentar contato')
    click_button('Sim')

    expect(page).to have_element(
      tag_name: 'span',
      data_contact_attempt_success: 'true',
      data_contact_attempt_type: 'intercom'
    )

    # intercom false
    click_element(tag_name: 'span', data_apartment: apartment.number)
    click_on('Tentar contato')
    click_label('Interfone')
    click_button('Não')

    expand_entries

    expect(page).to have_element(
      tag_name: 'span',
      data_contact_attempt_success: 'false',
      data_contact_attempt_type: 'intercom'
    )

    expand_entries

    # letter true
    click_element(tag_name: 'span', data_apartment: apartment.number)
    click_on('Tentar contato')
    click_label('Carta')
    click_button('Sim')

    expand_entries

    expect(page).to have_element(
      tag_name: 'span',
      data_contact_attempt_success: 'true',
      data_contact_attempt_type: 'letter'
    )
  end

  def expand_entries
    page.wait_until do
      page.has_element?(tag_name: 'span', data_apartment: apartment.number)
    end

    click_element(tag_name: 'span', text: /#{Date.today.year}/)
  end
end
