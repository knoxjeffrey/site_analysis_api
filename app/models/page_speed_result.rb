class PageSpeedResult < ActiveRecord::Base
  belongs_to :project

  def self.store_overview_data(site_analysis_array, project_id)
    site_analysis_array.each do |data|
      self.create(project_id: project_id, address: data.site_address, strategy: data.strategy, rule_groups: data.rule_groups, stats: data.stats, insights: data.insights, problems: data.problems)
    end
  end

end