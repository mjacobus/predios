# frozen_string_literal: true

RSpec.describe Web::Views::Users::Index, type: :view do
  let(:exposures) { Hash[format: :html] }
  let(:template_path) { 'apps/web/templates/users/index.html.erb' }
  let(:template)  { Hanami::View::Template.new(template_path) }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end
end
