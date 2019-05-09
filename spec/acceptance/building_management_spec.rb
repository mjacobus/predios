# frozen_string_literal: true

require 'acceptance_helper'

RSpec.describe 'Managing buildings', type: :acceptance do
  before do
    clear_all
    login_as_master
  end

  specify 'creating a building' do
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

  specify 'adding apartments' do
    building = building_factory.create(number_of_apartments: 2)

    visit('/buildings')
    click_on(building.name)

    expect(page).to have_element(placeholder: 'Número do Apartamento')

    # blank
    click_button('Adicionar')
    expect(page).to have_content('Número não pode ficar em branco')

    # first insert
    fill_in(nil, placeholder: 'Número do Apartamento', with: '01')
    click_button('Adicionar')
    expect(page).to have_element(tag_name: 'span', text: '01')

    # duplicate attempt
    fill_in(nil, placeholder: 'Número do Apartamento', with: '01')
    click_button('Adicionar')
    expect(page).to have_content('Apartamento já existe')

    # new record created
    fill_in(nil, placeholder: 'Número do Apartamento', with: '02')
    click_button('Adicionar')

    # form disapears
    expect(page).to have_no_element(placeholder: 'Número do Apartamento')
  end
end
