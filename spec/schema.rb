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
    attribute :comments, ref: :comment, array: true
  end

  define :comment do
    attribute :id, type: :number
    attribute :content
  end

  define :post_with_nullable_author do
    attribute :id, type: :number
    attribute :content
    attribute :author, ref: :user, nullable: true
    attribute :comments, ref: :comment, array: true
  end

  define :post_with_optional_author do
    attribute :id, type: :number
    attribute :content
    attribute :author, required: true, nullable: true do
      attribute :id, type: :number
      attribute :first_name
      attribute :last_name
      attribute :email
      attribute :mobile
      attribute :post_ids, type: :array
      attribute :is_admin, type: :boolean, optional: true
    end
    attribute :comments, ref: :comment, array: true
  end
end
