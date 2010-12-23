class Package < ActiveRecord::Base
  include Noid::ActiveRecord::Provider
  identifier_field :identifier
  minter Noid::Persistence::JSON.new(:template => 's.sdd', :filename => persistence_path )

  has_many :assets, :as => :attachable, :dependent => :destroy

  after_commit :bag_manifest

  def bag
    BagIt::Bag.new(object_path)
  end

  def object_path
    File.join RAILS_ROOT, 'data', self.identifier
  end

  private
  def bag_manifest
    self.bag.manifest!
  end
end
