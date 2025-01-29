class Sale < ApplicationRecord

  def self.active
    where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end

  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end

  validate :start_date_in_future
  validate :end_date_after_start_date

  private

  def start_date_in_future
    if starts_on.present? && starts_on <= Date.today
      errors.add(:starts_on, "must be in the future")
    end
  end

  def end_date_after_start_date
    if ends_on.present? && ends_on < starts_on
      errors.add(:ends_on, "must be on or after the start date")
    end
  end
end
