defmodule Homework.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "companies" do
     field(:name, :string)
     field(:description, :string)
     field(:credit_line, :integer)
     field(:available_credit, :integer)
  end  

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [:name, :description, :credit_line, :available_credit])
    |> validate_required([:name, :description, :credit_line, :available_credit])
  end
end