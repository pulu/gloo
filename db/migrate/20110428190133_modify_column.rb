class ModifyColumn < ActiveRecord::Migration
  def self.up
    rename_column :horses, :dna_test_fname, :dna_test_file_name
  end

  def self.down
  end
end
