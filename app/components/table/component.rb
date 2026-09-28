# frozen_string_literal: true

class Table::Component < ApplicationViewComponent
  renders_many :columns, Table::Column::Component
  renders_many :table_rows, Table::Row::Component
end
