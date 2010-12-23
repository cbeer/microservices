class Asset < ActiveRecord::Base
  attr_accessor :attachable_data_path

  has_attached_file :data, :url => "/assets/:id", :path => ":attachable_data_path/:basename.:style.:extension"

  after_commit :save_attachable

  belongs_to :attachable, :polymorphic => true
  
  def url(*args)
    data.url(*args)
  end
  
  def name
    data_file_name
  end
  
  def content_type
    data_content_type
  end
  
  def file_size
    data_file_size
  end

  def attachable_data_path
    return self.attachable.bag.data_dir if self.attachable
    @attachable_data_path = File.join RAILS_ROOT, 'holding'
  end

  protected

  def save_attachable
    self.attachable.save
  end
end
