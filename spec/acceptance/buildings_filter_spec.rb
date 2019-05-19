# frozen_string_literal: true

require 'acceptance_helper'

RSpec.describe 'Filtering buildings', type: :acceptance do
  before do
    clear_all
    login

    building_factory.create(
      name: 'Letter 1',
      has_individual_letterboxes: true,
      has_individual_intercoms: false
    )

    building_factory.create(
      name: 'Letter 2',
      has_individual_letterboxes: true,
      has_individual_intercoms: false
    )

    building_factory.create(
      name: 'Intercom 1',
      has_individual_letterboxes: false,
      has_individual_intercoms: true
    )

    building_factory.create(
      name: 'Intercom 2',
      number: 'Number Two',
      address: 'Address Two',
      has_individual_letterboxes: false,
      has_individual_intercoms: true
    )
  end

  specify 'creating a building' do
    visit('/buildings')

    expect(page).to have_contents([
      'Letter 1',
      'Letter 2',
      'Intercom 1',
      'Intercom 2',
      'Number Two',
      'Address Two',
    ])

    click_label('Interfone')

    expect(page).to have_contents([
      'Intercom 1',
      'Intercom 2',
    ])

    expect(page).to have_no_contents([
      'Letter 1',
      'Letter 2',
    ])

    click_label('Cartas')

    expect(page).to have_no_contents([
      'Intercom 1',
      'Intercom 2',
    ])

    expect(page).to have_contents([
      'Letter 1',
      'Letter 2',
    ])

    click_button('Limpar')

    expect(page).to have_contents([
      'Letter 1',
      'Letter 2',
      'Intercom 1',
      'Intercom 2',
      'Number Two',
      'Address Two',
    ])

    fill_in(:filter, with: '2')

    expect(page).to have_no_contents([
      'Letter 1',
      'Intercom 1',
    ])

    expect(page).to have_contents([
      'Letter 2',
      'Intercom 2',
    ])

    fill_in(:filter, with: 'Two')

    expect(page).to have_no_contents([
      'Letter',
      'Intercom 1',
    ])

    expect(page).to have_content('Intercom 2')
  end
end
