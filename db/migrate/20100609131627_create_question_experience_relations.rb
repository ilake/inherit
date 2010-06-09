class CreateQuestionExperienceRelations < ActiveRecord::Migration
  def self.up
    create_table :question_experience_relations do |t|
      t.integer :question_id
      t.integer :experience_id
      t.timestamps
    end

    add_index :question_experience_relations, [:question_id, :experience_id], :name => 'by_que_exp'
  end
  
  def self.down
    drop_table :question_experience_relations
  end
end
