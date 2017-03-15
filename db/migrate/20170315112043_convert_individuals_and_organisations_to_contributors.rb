class ConvertIndividualsAndOrganisationsToContributors < ActiveRecord::Migration[5.0]
  def change
    Place.where(type: %w(Organisation Individual)).update_all(type: "Contributor")
  end
end
