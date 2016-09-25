class CreateUserIndustries < ActiveRecord::Migration
  def change
    create_table :user_industries do |t|
      t.references :user, index: true
      t.references :industry, index: true

      t.timestamps
    end
  end
end
