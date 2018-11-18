# frozen_string_literal: true

class EntityFactory
  def clear
    repository.clear
  end

  def create(attributes = {})
    entity = sample(attributes)
    repository.create(entity)
  end

  def sample(attributes = {})
    new_attributes = sample_attributes.merge(attributes)
    entity_class.new(new_attributes)
  end

  def repository
    @repository ||= begin
      Object.const_get("#{entity_class}Repository").new
    end
  end

  private

  def entity_class
    Object.const_get(self.class.to_s.split('Factory').first)
  end

  def sequence
    @sequence ||= 0
    @sequence += 1
  end

  def with_sequence
    yield(sequence)
  end

  def sample_email(sequence)
    "email#{sequence}@email.com"
  end

  # rubocop:disable Metrics/MethodLength
  def sample_attributes
    {}.tap do |data|
      with_sequence do |seq|
        sampled_attributes.each do |attr_name|
          value = "#{attr_name} #{seq}"
          sample_method = "sample_#{attr_name}"

          if respond_to?(sample_method, true)
            value = send(sample_method, seq)
          end

          data[attr_name] = value
        end
      end
    end
  end
end
