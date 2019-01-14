# frozen_string_literal: true

module EventSpecHelper
  def self.included(base)
    base.class_eval do
      let(:event_class) { described_class }
    end
  end

  def create_event(payload)
    event_class.new(payload)
  end
end
