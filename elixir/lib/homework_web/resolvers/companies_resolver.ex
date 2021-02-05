defmodule HomeworkWeb.Resolvers.CompaniesResolver do
  alias Homework.Companies

  @doc """
  Get a list of companys
  """
  def companys(_root, args, _info) do
    {:ok, Companies.list_companies(args)}
  end

   @doc """
  Searching the company based on their name
  """
  def fuzzy_company(_root, %{name: name}, _info) do
    {:ok, Companies.search_company(name}
  end

  @doc """
  Create a new company
  """
  def create_company(_root, args, _info) do
    creditArgs = Map.put(args, :available_credit, Map.get(args, :credit_line))
    case Companies.create_company(creditArgs) do
      {:ok, company} ->
        {:ok, company}

      error ->
        {:error, "could not create company: #{inspect(error)}"}
    end
  end

  @doc """
  Updates a company for an id with args specified.
  """
  def update_company(_root, %{id: id} = args, _info) do
    company = Companies.get_company!(id)

    case Companies.update_company(company, args) do
      {:ok, company} ->
        {:ok, company} ->
            credit = Map.put(credit, :available_credit, company.available_credit)
            {:ok, credit}
        error ->
         {:error, "could not update available credit for company #{inspect(error)}"}

      error ->
        {:error, "could not update company: #{inspect(error)}"}
    end
  end

  @doc """
  Deletes a company for an id
  """
  def delete_company(_root, %{id: id}, _info) do
    company = Companies.get_company!(id)

    case Companies.delete_company(company) do
      {:ok, company} ->
        {:ok, company}

      error ->
        {:error, "could not update company: #{inspect(error)}"}
    end
  end
end
