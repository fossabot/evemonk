# frozen_string_literal: true
class CharacterDecorator < Draper::Decorator
  delegate_all

  decorates_association :race

  def as_json(*)
    {
      id: id,
      uid: uid,
      name: name,
      # TODO: later
      # corporation_id: corporation_id,
      # birthday: birthday,
      # gender: gender,
      race: race,
      # bloodline_id: bloodline_id,
      # description: description,
      # alliance_id: alliance_id,
      # ancestry_id: ancestry_id,
      security_status: security_status,
      # portrait: {
      #   small: portrait_small,
      #   medium: portrait_medium,
      #   large: portrait_large,
      #   huge: portrait_huge
      # },
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end
end
