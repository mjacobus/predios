# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'Managing buildings', type: :feature do
  before { clear_all }

  it 'does something' do
    login_as_master
    visit('/buildings/new')

    expect(page).to have_content('Criação de Prédio')

    fill_in(:number, with: '')
    fill_in(:name, with: 'Building Name')
    fill_in(:address, with: 'Rua Foo Bar')
    fill_in(:name, with: '')
    fill_in(:number_of_apartments, with: '40')
    fill_in(:neighborhood, with: 'The Hood')

    select('Sim', from: 'has_individual_intercoms')
    select('Não', from: 'has_individual_letterboxes')

    # invalid, name is blank
    click_on('Salvar')

    expect(page).to have_content('Não pode ficar em branco')

    # valid
    fill_in(:number, with: '123')
    click_on('Salvar')

    # byebug
    click_on('Building Name') # details
    click_on('Building Name') # edit

    # byebug
    expect(page).to have_element(name: 'name', value: 'Building Name')

    # edit
    fill_in(:name, with: 'Foo Bar')
    click_on('Salvar')
    click_on('Foo Bar')
  end
end
