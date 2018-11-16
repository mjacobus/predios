# frozen_string_literal: true

module MySpecUtils
  def stringify_keys(hash, deep: true)
    Koine::Utils.hash.stringify(hash, deep: deep)
  end

  def symbolize_keys(hash, deep: true)
    Koine::Utils.hash.symbolize(hash, deep: deep)
  end

  def with_immutable(input_object, check_type: true)
    output_object = yield(input_object)
    expect(output_object).not_to(be(input_object), 'Input object and output object are the same')
    expect(input_object).to(be_frozen, 'Input object is not frozen')
    expect(output_object).to(be_frozen, 'Output object is not frozen')

    if check_type
      expect(output_object.class).to(be(input_object.class), 'Output object is not frozen')
    end

    output_object
  end

  def sample_aggregate(overrides = {})
    params = { title: 'the-title', body: 'the-body' }
    Article::AggregateRoot.create(params.merge(overrides))
  end
end
