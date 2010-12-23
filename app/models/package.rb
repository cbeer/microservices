class Package < ActiveRecord::Base
  include Noid::ActiveRecord::Provider
  identifier_field :identifier
  minter Noid::Persistence::JSON.new(:template => 's.sdd', :filename => persistence_path )

  has_many :assets, :as => :attachable, :dependent => :destroy
end
