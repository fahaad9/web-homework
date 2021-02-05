defmodule HomeworkWeb.Schema do
  @moduledoc """
  Defines the graphql schema for this project.
  """
  use Absinthe.Schema

  alias HomeworkWeb.Resolvers.MerchantsResolver
  alias HomeworkWeb.Resolvers.TransactionsResolver
  alias HomeworkWeb.Resolvers.UsersResolver
  alias HomeworkWeb.Resolvers.CompaniesResolver
  import_types(HomeworkWeb.Schemas.Types)

  query do
    @desc "Get all Transactions"
    field(:transactions, list_of(:transaction)) do
      resolve(&TransactionsResolver.transactions/3)
    end

    query do
      @desc "Get Transactions between Min and Max"
      field(:minmax_transactions, list_of(:transaction)) do
        arg: min, non_null(:integer)
        arg: max, non_null(:integer)
        resolve(&TransactionsResolver.minmax_transactions/3)
      end

    @desc "Get all Users"
    field(:users, list_of(:user)) do
      resolve(&UsersResolver.users/3)
    end

    desc "Get all Companies"
    field(:companies, list_of(:company)) do
      resolve(&CompaniesResolver.companies/3)
    end

    @desc "Fuzzy Search Users"
     field(:fuzzy_users, list_of(:user)) do
       arg :firstname, non_null(:string)
       arg :lastname, non_null(:string)
       resolve(&UsersResolver.fuzzy_users/3)
     end

    @desc "Get all Merchants"
    field(:merchants, list_of(:merchant)) do
      resolve(&MerchantsResolver.merchants/3)
    end
    
    @desc "Search Merchant"
     field(:search_merchant, list_of(:merchant)) do
       arg :name, non_null(:string)
       resolve(&MerchantsResolver.search_merchant/3)
     end
  end

  mutation do
    import_fields(:transaction_mutations)
    import_fields(:user_mutations)
    import_fields(:merchant_mutations)
    import_fields(:company_mutations)
  end
end
