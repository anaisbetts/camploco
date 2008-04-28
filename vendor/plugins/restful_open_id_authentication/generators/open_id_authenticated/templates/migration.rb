class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %>, :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      t.column :open_id_url,               :string
      <% if options[:include_activation] %>
      t.column :activation_code, :string, :limit => 40
      t.column :activated_at, :datetime<% end %>
    end
    
    create_table :open_id_associations, :force => true do |t|
      t.column :server_url,   :binary
      t.column :handle,       :string
      t.column :secret,       :binary
      t.column :issued,       :integer
      t.column :lifetime,     :integer
      t.column :assoc_type,   :string
    end

    create_table :open_id_nonces, :force => true do |t|
      t.column :nonce,        :string
      t.column :created,      :integer
    end

    create_table :open_id_settings, :force => true do |t|
      t.column :setting,      :string
      t.column :value,        :binary
    end
  end

  def self.down
    drop_table :<%= table_name %>
    drop_table :open_id_associations
    drop_table :open_id_nonces
    drop_table :open_id_settings
  end

end
