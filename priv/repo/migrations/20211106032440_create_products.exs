defmodule App.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
        add(:name,:string)
        add(:price,:string)
        add(:image,:string)
        # add(:create_at,:utc_datetime)
        timestamps(type: :utc_datetime)
      end
    end
end
