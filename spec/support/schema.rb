ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string  :name
    t.integer :age
    t.string  :ssn
    t.timestamps
  end
  
  create_table :addresses, :force => true do |t|
    t.string :street
    t.string :number
    t.string :notes
    t.timestamps
  end
  
  create_table :titles, :force => true do |t|
    t.string :description
    t.integer :base_salary
    t.timestamps
  end
end
