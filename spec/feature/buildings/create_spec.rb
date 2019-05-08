# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'creating buildings', type: :feature do
  it 'does something' do
    login_as_master
    visit('/buildings/new')

    expect(page).to have_content('Criação de Prédio')

    fill_in(:number, with: '')
    fill_in(:address, with: 'foo')
    fill_in(:name, with: 'foo')
    fill_in(:number_of_apartments, with: 'foo')
    fill_in(:neighborhood, with: 'foo')

    select('Sim', from: 'has_individual_intercoms')
    select('Sim', from: 'has_individual_letterboxes')

    click_on('Salvar')

    expect(page).to have_content('Não pode ficar em branco')
  end
end
