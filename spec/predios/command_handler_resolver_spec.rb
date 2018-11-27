# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CommandHandlerResolver do
  let(:dependencies) { instance_double(AppDependencies) }
  let(:resolver) { described_class.new(dependencies: dependencies) }
  let(:command) { double(:command, class: fake_class) }
  let(:is_defined) { false }
  let(:resolved) { resolver.resolve(command) }
  let(:fake_handler) { nil }

  before do
    allow(dependencies).to receive(:defined?)
      .with(key)
      .and_return(is_defined)
  end

  context 'when command is a command' do
    let(:key) { 'command_handlers.some_parent_class.do_something_nice' }
    let(:fake_class) do
      double(
        to_s: 'SomeParentClass::Commands::DoSomethingNice',
        new: fake_handler
      )
    end

    context 'when command handler is registered' do
      let(:is_defined) { true }
      let(:handler) { :the_handler }

      before do
        allow(dependencies).to receive(:get)
          .with(key)
          .and_return(handler)
      end

      it 'returns the registered command handler' do
        expect(resolved).to be(handler)
      end
    end

    context 'when command handler is not registered' do
      before do
        allow(Object).to receive(:const_defined?)
          .with('SomeParentClass::CommandHandlers::DoSomethingNice')
          .and_return(type_exists)
      end

      context 'when handler type exists' do
        let(:fake_handler) { double(:fake_handler) }
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

  context 'when command is a query' do
    let(:key) { 'query_handlers.some_parent_class.do_something_nice' }
    let(:fake_class) do
      double(
        to_s: 'SomeParentClass::Queries::DoSomethingNice',
        new: fake_handler
      )
    end

    context 'when query handler is registered' do
      let(:is_defined) { true }
      let(:handler) { :the_handler }

      before do
        allow(dependencies).to receive(:get)
          .with(key)
          .and_return(handler)
      end

      it 'returns the registered query handler' do
        expect(resolved).to be(handler)
      end
    end

    context 'when query handler is not registered' do
      before do
        allow(Object).to receive(:const_defined?)
          .with('SomeParentClass::QueryHandlers::DoSomethingNice')
          .and_return(type_exists)
      end

      context 'when handler type exists' do
        let(:fake_handler) { double(:fake_handler) }
        let(:type_exists) { true }

        before do
          allow(Object).to receive(:const_get)
            .with('SomeParentClass::QueryHandlers::DoSomethingNice')
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
end
