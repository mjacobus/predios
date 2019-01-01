# frozen_string_literal: true

class ContactAttemptProjectionFactory < EntityFactory
  def sample(attributes)
    if attributes[:apartment]
      attributes[:apartment_id] = attributes.delete(:apartment).id
    end

    unless attributes[:apartment_id]
      attributes[:apartment_id] = ApartmentProjectionFactory.new.create.id
    end

    super(attributes)
  end

  private

  def sampled_attributes
    %i[
      outcome
      time
    ]
  end

  def sample_time(sequence)
    Time.now - 60 + sequence
  end

  def sample_outcome(_sequence)
    %w[contacted failed].sample
  end
end
