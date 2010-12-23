class Package < ActiveRecord::Base
  include Noid::ActiveRecord::Provider
  include LockIt::Mixin
  identifier_field :identifier
  minter Noid::Persistence::JSON.new(:template => 's.sdd', :filename => persistence_path )

  has_many :assets, :as => :attachable, :dependent => :destroy

  after_commit :bag_manifest

  def path
    self.object_path
  end

  def bag
    FileUtils.mkdir_p object_path unless File.exists? object_path
    BagIt::Bag.new(object_path)
  end

  def object_path
    File.join RAILS_ROOT, 'data', Pairtree::Path.id_to_path(self.identifier)
  end

  private
  def bag_manifest
    self.bag.manifest!
  end
end
