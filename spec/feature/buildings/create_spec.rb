# frozen_string_literal: true

require 'features_helper'

RSpec.describe 'creating buildings', type: :feature do
  it 'does something' do
    login_as_master
    visit('/buildings/new')
    expect(page).to have_content('Criação de Prédio')

    # wip
  end
end
