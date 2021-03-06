# Defines Trip model
class Trip < ApplicationRecord
  validates :start_date, presence: true
  validates :start_station, presence: true
  validates :bike_id, presence: true
  validates :subscription_type, presence: true

  belongs_to :start_station, :class_name => 'Station'
  belongs_to :end_station, :class_name => 'Station'

  def self.average_rides(info_hash)
    select('trips.*, conditions.*')
    .joins('INNER JOIN conditions ON trips.start_date = conditions.date')
    .group('conditions.date')
    .where(info_hash)
  end

  def self.average_duration
    (average(:duration).to_f / 60).round(2)
  end

  def self.longest_ride
    order(duration: :desc).first
  end

  def self.shortest_ride
    order(duration: :asc).first
  end

  def self.rides_by_month
    group("to_char(start_date, 'FMyyyy mm')")
      .group("to_char(start_date, 'FMMonth yyyy')")
      .order("to_char(start_date, 'FMyyyy mm')")
      .count
  end

  def self.rides_by_year
    group("to_char(start_date, 'FMyyyy')").count
  end

  def self.most_ridden_bike
    group(:bike_id)
      .order('count(trips.id) DESC')
      .count
      .first
  end

  def self.least_ridden_bike
    group(:bike_id)
      .order('count(trips.id) ASC')
      .count
      .first
  end

  def self.subscription_metrics
    group(:subscription_type).count
  end

  def self.most_trips_date
    group("to_char(start_date, 'FMyyyy-mm-dd')")
      .order('count(trips.id) DESC')
      .count
      .first
  end

  def self.least_trips_date
    group("to_char(start_date, 'FMyyyy-mm-dd')")
      .order('count(trips.id) ASC')
      .count
      .first
  end
end
