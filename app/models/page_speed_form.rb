class PageSpeedForm
  attr_accessor :site_address, :strategy

  include ActiveModel::Model

  validates :site_address, presence: true
  validates :strategy, presence: true

  def self.strategy_types
    ["mobile", "desktop"]
  end

end
