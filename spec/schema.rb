SchemaMatcher.build_schema do
  define :user do
    attribute :id, type: :number
    attribute :first_name
    attribute :last_name
    attribute :email
    attribute :mobile
    attribute :post_ids, type: :array
    attribute :is_admin, type: :boolean, optional: true
  end

  define :post do
    attribute :id, type: :number
    attribute :content
    attribute :author, ref: :user
  end
end
