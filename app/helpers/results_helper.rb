module ResultsHelper
    def get_precentage_hash(results)
        total = results.count
        hash_data = {}
        results.group_by(&:result).each do |key, value|
            hash_data[key] = (value.count.to_f / total.to_f) * 100
        end
        hash_data
    end

    def get_failed_students(results)
        failed_students = []
        results.group_by(&:result).fetch('F', []).each do |result|
            failed_students << User.find(result.user_id).reg_no
        end
        failed_students
    end
end
