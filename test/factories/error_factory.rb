# == Schema Information
#
# Table name: errors
#
#  id          :integer          not null, primary key
#  status      :integer          default("pending"), not null
#  exception   :string           default(""), not null
#  file_name   :string
#  line_number :integer
#  label       :string           default(""), not null
#  message     :string           default(""), not null
#  backtrace   :string           default([]), not null, is an Array
#  context     :json             not null
#  occured_at  :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  target_type :string
#  target_id   :bigint
#
# Indexes
#
#  index_errors_on_exception                  (exception)
#  index_errors_on_file_name                  (file_name)
#  index_errors_on_occured_at                 (occured_at)
#  index_errors_on_status                     (status)
#  index_errors_on_target_type_and_target_id  (target_type,target_id)
#

FactoryBot.define do
  factory :error, class: Error do
    context { {} }
  end
end
