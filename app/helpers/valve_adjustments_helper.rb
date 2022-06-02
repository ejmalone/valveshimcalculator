# frozen_string_literal: true

module ValveAdjustmentsHelper
  def short_mileage(mileage)
    "#{ mileage / 1000 }k mile"
  end

  def valve_adjust_attrs(status)
    classname, title = case status
      when ValveAdjustments::IN_SPEC; ['in-spec', 'Well within threshold']
      when ValveAdjustments::MIN_SPEC; [ 'min-spec', 'Meets threshold but should be adjusted soon']
      when ValveAdjustments::OUT_OF_SPEC; [ 'out-of-spec', 'At limit or out of specification']
      else [ 'unknown-spec', 'Unknown specification status']
    end

    { class: classname, title: title }
  end
end
