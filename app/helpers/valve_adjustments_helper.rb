# frozen_string_literal: true

module ValveAdjustmentsHelper
  def short_mileage(mileage)
    "#{mileage / 1000}k mile"
  end

  def valve_adjust_attrs(status)
    classname, title = case status
                       when ValveAdjustment::IN_SPEC then ['in-spec', 'Well within threshold']
                       when ValveAdjustment::MIN_SPEC then ['min-spec', 'Meets threshold but should be adjusted soon']
                       when ValveAdjustment::OUT_OF_SPEC then ['out-of-spec', 'At limit or out of specification']
                       else ['unknown-spec', 'Unknown specification status']
                       end

    { class: classname, title: title }
  end
end
