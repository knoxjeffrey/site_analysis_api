class Project < ActiveRecord::Base

  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :page_speed_results
  belongs_to :admin, foreign_key: 'admin_id', class_name: 'User'

  validates :project_name, presence: true, uniqueness: true, length: {minimum: 3}
end