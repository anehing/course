class Instance < ApplicationRecord
  # @!attribute [r] instance_users
  #   @note You are scoped by the current tenant, you might not see all.
  has_many :instance_users, dependent: :destroy

  # @!attribute [r] users
  #   @note You are scoped by the current tenant, you might not see all.
  has_many :users, through: :instance_users
  has_many :coourses, dependent: :destroy

  has_many :instance_announcements, class_name: "Instance::Announcement", dependent: :destroy

  validates :host, length: { maximum: 255 }, presence: true, uniqueness: { case_sensitive: false, if: :host_changed? }
  validates :host, hostname: true, if: :should_validate_host?

  scope :order_by_name, ->(direction = :asc) { order(name: direction) }
  scope :order_for_display, -> { order(Arel.sql("CASE \"id\" WHEN #{DEFAULT_INSTANCE_ID} THEN 0 ELSE 1 END")).order_by_name }

  DEFAULT_INSTANCE_ID = 0
  class << self
    def default
      @default ||= find_by(id: DEFAULT_INSTANCE_ID)
      raise 'Unknown instance. Did you run rake db:seed?' unless @default

      @default
    end

    # Finds the given tenant by host.
    #
    # @param [String] host The host to look up. This is case insensitive, however prefixes (such
    #   as www) are not handled automatically.
    # @return [Instance]
    def find_tenant_by_host(host)
      where(Instance.arel_table[:host].lower.eq(host.downcase)).take
    end

    # Finds the given tenant by host, falling back to the default is none is found.
    #
    # @param [String] host The host to look up. This is case insensitive, however prefixes (such
    #   as www) are not handled automatically.
    # @return [Instance]
    def find_tenant_by_host_or_default(host)
      find_tenant_by_host(host) || default
    end
  end


  private
  def should_validate_host?
    new_record? || host_changed?
  end


end
