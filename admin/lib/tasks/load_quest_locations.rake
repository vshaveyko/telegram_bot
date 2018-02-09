namespace :quest_location do

  desc 'Fill QuestLocation'
  task fill: :environment do
    CSV.foreach("#{Rails.root}/lib/tasks/qlocation.csv", headers: true) do |row|
      row = row.to_h

      row = row.each_with_object({}) do |(k, v), result|
        result[k] = begin
                      eval(v) # rubocop:disable all
                    rescue Exception # rubocop:disable all
                      v
                    end
      end

      ql = QuestLocation.find_by(address: row['address'])

      if ql
        ql.update!(row)
        next
      end

      QuestLocation.create!(row)
    end
  end

  desc 'Fill QuestLocation comments'
  task fill_comments: :environment do
    CSV.foreach("#{Rails.root}/lib/tasks/qcomments.csv", headers: true) do |row|
      row = row.to_h

      QuestComment.find_or_create_by(row)
    end
  end

end
