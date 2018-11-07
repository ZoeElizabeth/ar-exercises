require_relative '../setup'
require_relative './exercise_1'
require_relative './exercise_2'
require_relative './exercise_3'
require_relative './exercise_4'
require_relative './exercise_5'
require_relative './exercise_6'

puts "Exercise 7"
puts "----------"

# Your code goes here ...
# 1. Add validations to two models to enforce the following 
# business rules:
#   * Employees must always have a first name present
#   * Employees must always have a last name present
#   * Employees have a hourly_rate that is a number (integer) 
#   between 40 and 200
#   * Employees must always have a store that they belong to 
#   (can't have an employee that is not assigned a store)
#   * Stores must always have a name that is a minimum of 3 
#   characters
#   * Stores have an annual_revenue that is a number (integer) 
#   that must be 0 or more
#   * BONUS: Stores must carry at least one of the men's or women's 
#   apparel 
#   (hint: use a [custom validation method](http://guides.rubyonrails.org/active_record_validations.html#custom-methods)
#    - **don't** use a `Validator` class)
# 2. Ask the user for a store name (store it in a variable)
# 3. Attempt to create a store with the inputted name but leave out
#  the other fields (annual_revenue, mens_apparel, and womens_apparel)
# 4. Display the error messages provided back from ActiveRecord to 
# the user (one on each line) after you attempt to save/create the 
# record



class Store < ActiveRecord::Base 
  validates :name, presence: true, length: { minimum: 3 } 
  validates :annual_revenue, numericality: { greater_than: 0 }
end

class Employee < ActiveRecord::Base
 validates :first_name, presence: true
 validates :last_name, presence: true
 validates :store_id, numericality: { greater_than: 0, less_than: Store.count }
 validates :hourly_rate, numericality: { greater_than: 40, less_than: 200 }  
end

puts "Create new Store"
store_name = gets.chomp
puts "How much dose your store make annually?"
revenue = gets.chomp

new_store = Store.create(name: store_name, annual_revenue: revenue)
p new_store.valid?
pp new_store.errors.messages



# * Employees must always have a first name present
#   * Employees must always have a last name present
#   * Employees have a hourly_rate that is a number (integer) 
#   between 40 and 200
#   * Employees must always have a store that they belong to 
#   (can't have an employee that is not assigned a store)

# class Employee < ActiveRecord::Base
#   validate :first_name_cannot_be_empty, :last_name_cannot_be_empty,
#   :hourly_rate_cannot_be_empty_and_is_number, :employee_must_belong_to_store

#   def first_name_cannot_be_empty
#     if first_name.present? 
#       errors.add(:first_name, "can't be empty")
#     end
#   end

#   def last_name_cannot_be_empty
#     if last_name.present? 
#       errors.add(:last_name, "can't be empty")
#     end
#   end

#   def hourly_rate_cannot_be_empty_and_is_number
#     if hourly_rate.present? && Numeric && 40..200
#       errors.add(:hourly_rate, "must be a number between 40-200")
#     end
#   end

#   def employee_must_belong_to_store
#     if store_id.present? 
#       errors.add(:store_id, "must be assigned")
#     end
#   end
# end

# class Store < ActiveRecord::Base
#   validate :store_must_have_annual_revenue_number
  

#   def store_must_have_annual_revenue_number
#     if hourly_rate.present? && Numeric && 0..Float::INFINITY
#       errors.add(:hourly_rate, "must be a number over 1")
#     end
#   end

# end

# storey = Store.create annual_revenue: 430000, mens_apparel: 'true', womens_apparel: 'true'