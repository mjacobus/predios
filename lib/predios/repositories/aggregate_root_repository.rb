# frozen_string_literal: true

class AggregateRootRepository < Koine::EventSourcing::AggregateRootRepository
  def save(*args)
    transaction do
      super(*args)
    end
  end

  private

  def transaction(&block)
    UserRepository.new.transaction(&block)
  end
end
