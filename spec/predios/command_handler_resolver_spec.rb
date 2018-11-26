# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CommandHandlerResolver do
  let(:dependencies) { instance_double(AppDependencies) }
  let(:resolver) { described_class.new(dependencies: dependencies) }
  let(:command) { double(:command, class: 'SomeParentClass::Commands::DoSomethingNice') }
  let(:is_defined) { false }
  let(:key) { 'command_handlers.some_parent_class.do_something_nice' }
  let(:resolved) { resolver.resolve(command) }

  before do
    allow(dependencies).to receive(:defined?)
      .with(key)
      .and_return(is_defined)
  end

  context 'when dependency is registered' do
    let(:is_defined) { true }
    let(:handler) { :the_handler }

    before do
      allow(dependencies).to receive(:get)
        .with(key)
        .and_return(handler)
    end

    it 'returns the registered dependency' do
      expect(resolved).to be(handler)
    end
  end

  context 'when dependency is not registered' do
    before do
      allow(Object).to receive(:const_defined?)
        .with('SomeParentClass::CommandHandlers::DoSomethingNice')
        .and_return(type_exists)
    end

    context 'when handler type exists' do
      let(:fake_handler) { double(:fake_handler) }
      let(:fake_class) { double(:klass, new: fake_handler) }
      let(:type_exists) { true }

      before do
        allow(Object).to receive(:const_get)
          .with('SomeParentClass::CommandHandlers::DoSomethingNice')
          .and_return(fake_class)
      end

      it 'returns an instance of that particular type' do
        expect(resolved).to be(fake_handler)
      end
    end

    context 'when handler type does not exist' do
      let(:type_exists) { false }

      it 'returns nil' do
        expect(resolved).to be_nil
      end
    end
  end
end
