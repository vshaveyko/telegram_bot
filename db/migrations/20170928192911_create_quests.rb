Sequel.migration do
  transaction
  change do
    create_table(:quests) do
      primary_key(:id, type: :Bignum)

      column(:name,           :text)
      column(:ppl_min,        :integer)
      column(:ppl_max,        :integer)
      column(:cost_min,       :integer)
      column(:cost_max,       :integer)
      column(:image_url,      :text)
      column(:lat,            :float)
      column(:long,           :float)
      column(:address,        :text)
      column(:estimated_time, :text)

      column(:position,      'geometry(Point, 4326)')
    end
  end
end
